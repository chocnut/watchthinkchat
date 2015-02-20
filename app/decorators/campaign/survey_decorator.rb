class Campaign
  class SurveyDecorator < Draper::Decorator
    decorates_association :question
    delegate_all

    def enabled
      return false unless enabled?
      !questions.empty?
    end
  end
end
