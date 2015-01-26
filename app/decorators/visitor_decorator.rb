class VisitorDecorator < Draper::Decorator
  delegate_all

  def name
    "#{first_name} #{last_name}".strip
  end

  def url(campaign)
    "#{campaign.try(:decorate).try(:permalink)}/i/#{share_token}"
  end

  def content(campaign)
    return nil unless campaign.growthspace.try(:enabled?)
    access_id_and_access_secret(campaign.growthspace)
    Campaign::Growthspace::Content.find(params: { route_id: latest_route_id(campaign),
                                                  language_id: I18n.locale })
  end

  private

  def access_id_and_access_secret(growthspace)
    return if growthspace.api_key.blank? && growthspace.api_secret.blank?
    Campaign::Growthspace::Content.access_id = growthspace.api_key
    Campaign::Growthspace::Content.access_secret = growthspace.api_secret
  end

  def latest_route_id(campaign)
    route_id = nil
    interactions
      .where(resource_type: 'Campaign::Survey::Question::Option',
             campaign: campaign)
      .order(:created_at)
      .each do |interaction|
      route_id = interaction.resource.route_id if interaction.resource.route_id
    end
    route_id
  end
end
