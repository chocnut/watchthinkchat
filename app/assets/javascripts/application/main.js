angular.module('chatApp', ['ngRoute', 'templates', 'ui.bootstrap', 'youtube-embed'])
    .config(function ($routeProvider) {
      $routeProvider.when('/', {
        template: '',
        controller: 'MainController'
      }).when('/player', {
        templateUrl: 'video.html',
        controller: 'VideoController'
      }).when('/q/:questionId', {
        templateUrl: 'question.html',
        controller: 'QuestionController',
        resolve: {
          question: ['$rootScope', '$route', function ($rootScope, $route) {
            return _.find($rootScope.campaign.survey.questions, { 'code': $route.current.params.questionId });
          }],
          nextQuestion: ['$rootScope', '$route', function ($rootScope, $route) {
            var questionIndex = _.findIndex($rootScope.campaign.survey.questions, { 'code': $route.current.params.questionId });
            return $rootScope.campaign.survey.questions[questionIndex + 1];
          }]
        }
      }).when('/o/:jumpId', {
        template: '',
        controller: 'JumpToController',
        resolve: {
          option: ['$rootScope', '$route', function ($rootScope, $route) {
            return _.find(_.flatten($rootScope.campaign.survey.questions, 'options'), { 'code': $route.current.params.jumpId });
          }]
        }
      }).when('/final', {
        templateUrl: 'final.html',
        controller: 'FinalController'
      }).otherwise({
        redirectTo: '/'
      });
    }).run(function ($rootScope, $window, $modal, api) {
      $rootScope.campaign = $window.campaign;
      $rootScope.translations = $window.translations;

      $rootScope.back = function(){
        $window.history.back();
      };

      $rootScope.privacyModal = function(){
        $modal.open({
          templateUrl: 'modals/privacyModal.html',
          controller: function($scope, $location, $sce, $modalInstance){
            var lang = $location.absUrl().split('/')[3];
            $scope.frameUrl = $sce.trustAsResourceUrl('/' + lang + '/privacy');

            $scope.close = function () {
              $modalInstance.dismiss();
            };
          },
          size: 'lg'
        });
      };

      $rootScope.$on('$routeChangeStart', function(event, next, current) {
        var nextController = next.$$route.controller;
        var currentController = '';
        if(angular.isDefined(current)){ currentController = current.$$route.controller; }

        if(nextController === currentController){
          return;
        }

        if(getResourceInfo(currentController)){
          api.interaction({
            interaction: {
              resource_id: getResourceInfo(currentController).id,
              resource_type: getResourceInfo(currentController).resource_type,
              action: 'finish'
            }
          });
        }

        if(getResourceInfo(nextController)){
          api.interaction({
            interaction: {
              resource_id: getResourceInfo(nextController).id,
              resource_type: getResourceInfo(nextController).resource_type,
              action: 'start'
            }
          });
        }
      });

      var getResourceInfo = function(controller){
        switch(controller) {
          case 'VideoController':
            return $rootScope.campaign.engagement_player;
          case 'QuestionController':
            return $rootScope.campaign.survey;
          case 'FinalController':
            return $rootScope.campaign.share;
          default:
            return null;
        }
      };
    }).config(["$httpProvider", function(provider) {
      //provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }]);
