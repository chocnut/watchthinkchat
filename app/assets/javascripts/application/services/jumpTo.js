angular.module('chatApp')
    .service('jumpTo', function ($rootScope, $location) {
      this.jump = function (option, nextQuestion) {
        switch (option.conditional) {
          case 'next':
            if(angular.isDefined(nextQuestion)){
              $location.path('/q/' + nextQuestion.code);
            }else{
              $location.path('/final');
            }
            break;
          case 'skip':
            $location.path('/q/' + option.conditional_question_id);
            break;
          case 'finish':
            $location.path('/final');
            break;
        }
      };
    });
