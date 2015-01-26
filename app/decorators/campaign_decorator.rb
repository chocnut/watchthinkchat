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
    1000
  end

  def starting_video
    86
  end

  def starting_video_percentage
    ((starting_video.to_d / unique_visitors.to_d) * 100).to_i
  end

  def finishing_video
    90
  end

  def finishing_video_percentage
    ((finishing_video.to_d / unique_visitors.to_d) * 100).to_i
  end

  def signing_up
    500
  end

  def signing_up_percentage
    ((signing_up.to_d / unique_visitors.to_d) * 100).to_i
  end
end
