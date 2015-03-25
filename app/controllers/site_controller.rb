class SiteController < ApplicationController
  before_action :load_campaign
  before_action :load_translations
  decorates_assigned :campaign

  def index
    return render 'no_campaign', layout: 'no_campaign', status: 404 unless @campaign
    return if @campaign.locales.find_by(code: I18n.locale) ||
              @campaign.locale.code.try(:to_sym) == I18n.locale
    redirect_to("/#{@campaign.locale.code}")
  end

  protected

  def load_translations
    @translations = I18n.backend.send(:translations)
    @translations = @translations[I18n.locale][:front_end]
  end

  def load_campaign
    url = request.host
    url.slice! ".#{ENV['base_url']}"
    url.slice! '.lvh.me' if Rails.env.test? # capybara-webkit bug
    @campaign = Campaign.opened.find_by(url: url)
  end
end
