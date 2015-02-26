class Campaign
  class Survey
    class Question < ActiveRecord::Base
      # associations
      belongs_to :survey
      has_many :options, dependent: :destroy
      accepts_nested_attributes_for :options, allow_destroy: true

      # validations
      validates :survey, presence: true
      validates :title, presence: true
      validates :code, presence: true, on: :update

      # definitions
      acts_as_list scope: :survey
      default_scope { order('position ASC') }
      translates :title, :help_text

      delegate :campaign, to: :survey

      def options_attributes
        options
      end

      def code
        Base62.encode id
      end
    end
  end
end
