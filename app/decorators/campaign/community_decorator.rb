require 'campaign'
class Campaign
  class CommunityDecorator < Draper::Decorator
    decorates Campaign::Community
    decorates_association :child_campaign
    delegate_all

    def permalink
      child_campaign.try(:permalink) || url
    end

    def display_title
      child_campaign.try(:name) || title
    end
  end
end
