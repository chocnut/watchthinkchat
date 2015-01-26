class Campaign
  class Growthspace < Component
    # validations
    validates :title, presence: true, if: :enabled?

    # definitions
    translates :title
  end
end
