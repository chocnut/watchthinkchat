angular.module('chatApp').controller('MainController', function ($scope, $rootScope, $location) {

  if($rootScope.campaign.engagement_player.enabled){
    $location.path('/player');
    return;
  }

  if($rootScope.campaign.survey.enabled){
    $location.path('/q/' + $rootScope.campaign.survey.questions[0].code);
    return;
  }

  $location.path('/final');
});