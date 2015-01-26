angular.module('chatApp').controller('QuestionController', function ($scope, jumpTo, question, nextQuestion, api) {
  $scope.question = question;

  $scope.buttonClick = function(option){
    api.interaction({
      interaction: {
        resource_id: option.id,
        resource_type: option.resource_type,
        action: 'click'
      }
    });
    jumpTo.jump(option, nextQuestion);
  };
});