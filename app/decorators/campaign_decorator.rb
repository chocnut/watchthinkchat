class CampaignDecorator < Draper::Decorator
  decorates_association :engagement_player
  decorates_association :survey
  decorates_association :community
  decorates_association :share
  delegate_all

  def permalink
    return "http://#{url}.#{ENV['base_url']}" if subdomain?
    "http://#{url}"
  end

  def unique_visitors
    campaign.interactions.group(:visitor_id).count.size
  end

  def starting_video
    campaign.interactions.where(resource_type: 'Campaign::EngagementPlayer').start.count
  end

  def starting_video_percentage
    return 0 if unique_visitors == 0
    ((starting_video.to_d / unique_visitors.to_d) * 100).to_i
  end

  def finishing_video
    campaign.interactions.where(resource_type: 'Campaign::EngagementPlayer').finish.count
  end

  def finishing_video_percentage
    return 0 if unique_visitors == 0
    ((finishing_video.to_d / unique_visitors.to_d) * 100).to_i
  end

  def signing_up
    Campaign::Growthspace::Subscriber.access_id = campaign.growthspace.api_key
    Campaign::Growthspace::Subscriber.access_secret = campaign.growthspace.api_secret
    Campaign::Growthspace::Subscriber.all.count
  rescue => e
    logger.error e.message
    0
  end

  def signing_up_percentage
    return 0 if unique_visitors == 0
    signing_up = 100 unless signing_up == 0
    ((unique_visitors.to_d / signing_up.to_d) * 100).to_i
  end
end
