class SiteController < ApplicationController
  before_action :load_campaign
  decorates_assigned :campaign

  def index
    return render 'no_campaign' unless @campaign
    return if @campaign.locales.find_by(code: I18n.locale) ||
              @campaign.locale.code.try(:to_sym) == I18n.locale
    redirect_to("/#{@campaign.locale.code}")
  end

  protected

  def load_campaign
    url = request.host
    url.slice! ".#{ENV['base_url']}"
    url.slice! '.lvh.me' if Rails.env.test? # capybara-webkit bug
    @campaign = Campaign.opened.find_by(url: url)
  end
end
