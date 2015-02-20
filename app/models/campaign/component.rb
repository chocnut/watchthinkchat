class Campaign
  class Component < ActiveRecord::Base
    self.abstract_class = true

    # associations
    belongs_to :campaign

    # validations
    validates :campaign, presence: true
    validates :enabled, inclusion: [true, false]
    validates :enabled, presence: true
  end
end
