class CampaignDecorator < Draper::Decorator
  decorates_association :engagement_player
  decorates_association :survey
  decorates_association :community
  decorates_association :share
  delegate_all

  def permalink
    return nil unless url
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
    0
  end

  def signing_up_percentage
    return 0 if unique_visitors == 0
    ((signing_up.to_d / unique_visitors.to_d) * 100).to_i
  end

  def name
    object.name || 'Untitled'
  end

  def icon
    %w(cloud cube coffee diamond)[id % 4]
  end

  def background
    %w(#cfb396 #f35b00 #f19e00 #5811af #e12814 #3494c7)[id % 6]
  end
end
