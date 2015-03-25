class Campaign
  class Survey
    class Question
      class Option < ActiveRecord::Base
        # associations
        belongs_to :question
        belongs_to :route, class_name: 'Campaign::Growthspace::Route'
        belongs_to :conditional_question,
                   class_name: 'Campaign::Survey::Question'

        # validations
        validates :title, presence: true
        validates :conditional, presence: true
        validates :question, presence: true, on: :update
        validates :conditional_question,
                  presence: true,
                  if: proc { self.skip? }

        # definitions
        enum conditional: [:next, :skip, :finish]
        default_scope { order('created_at ASC') }
        translates :title

        delegate :campaign, to: :question

        def code
          Base62.encode id
        end
      end
    end
  end
end
