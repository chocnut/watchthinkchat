angular.module('chatApp').controller('FinalController', function ($scope, $window, api) {
  api.call('get', '/v1/visitor', null, function(data){
    $scope.visitorInfo = data;
  });

  $scope.submitGrowthChallenge = function(){
    var visitorInfo = angular.copy($scope.visitorInfo);
    visitorInfo.subscribe = true;
    api.call('put', '/v1/visitor', visitorInfo, function(){
      $scope.growthChallengeSubscribe = true;
    }, function(){
      alert('An error occurred while submitting your information.');
    });
  };

  $scope.facebookShare = function(url){
    $window.open('https://www.facebook.com/sharer/sharer.php?u=' + encodeURIComponent(url), 'fbShare', 'height=250,width=650');
  };

  $scope.twitterShare = function(url){
    $window.open('https://twitter.com/share?url=' + encodeURIComponent(url), 'twitterShare', 'height=400,width=650');
  };

  $scope.toggleEmailForm = function(){
    $scope.showEmailForm = !$scope.showEmailForm;
  };

  $scope.sendEmailShare = function(){
    //update visitor
    api.call('put', '/v1/visitor', $scope.visitorInfo, function(){

      //create invitee
      api.call('post', '/v1/invitees', $scope.invitee, function(invitee){

        //send email
        api.call('post', '/v1/invitees/' + invitee.id + '/emails', $scope.email, function(){

        }, function(){
          alert('Error: could not send email.');
        });
      }, function(){
        alert('Error: could not create invitee.');
      });
    });
  };
});