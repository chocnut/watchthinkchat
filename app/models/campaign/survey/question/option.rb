class Campaign
  class Survey
    class Question
      class Option < ActiveRecord::Base
        # associations
        belongs_to :question
        has_one :conditional_question, class: 'Question'

        # callbacks
        after_save :generate_code, on: :create

        # validations
        validates :conditional, presence: true
        validates :title, presence: true
        validates :question, presence: true, on: :update
        validates :conditional_question_id,
                  presence: true,
                  if: proc { self.skip? }

        # definitions
        enum conditional: [:next, :skip, :finish]
        default_scope { order('created_at ASC') }
        translates :title

        delegate :campaign, to: :question

        protected

        def generate_code
          update_column(:code, Base62.encode(id))
        end
      end
    end
  end
end
