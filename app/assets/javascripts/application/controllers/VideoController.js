angular.module('chatApp').controller('VideoController', function ($scope, $rootScope, $location, api) {
  api.call('post', '/v1/interactions', {
    access_token: window.token,
    interaction: {
      resource_id: 0,
      resource_type: $rootScope.campaign.engagement_player.resource_type,
      action: 'start'
    }
  });
  $scope.playerVars = {
    autoplay: 0,
    modestbranding: 1,
    rel: 0,
    showinfo: 0,
    iv_load_policy: 3,
    html5: 1
  };
  if($rootScope.campaign.engagement_player.media_start){
    $scope.playerVars.start = $rootScope.campaign.engagement_player.media_start;
  }
  if($rootScope.campaign.engagement_player.media_stop){
    $scope.playerVars.end = $rootScope.campaign.engagement_player.media_stop;
  }

  $scope.$on('youtube.player.ended', function ($event, player) {
    if($rootScope.campaign.survey.enabled){
      $location.path('/q/' + $rootScope.campaign.survey.questions[0].code);
    }else{
      $location.path('/complete');
    }
  });
});