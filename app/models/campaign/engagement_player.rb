class Campaign
  class EngagementPlayer < Component
    # validations
    validates :media_link, presence: true, if: :enabled?

    # definitions
    translates :media_link
  end
end
