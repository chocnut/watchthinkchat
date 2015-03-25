require 'rails_helper'

describe 'Site', type: :feature, js: true do
  before do
    page.driver.browser.url_blacklist = ['http://fonts.googleapis.com']
  end
  feature 'cname' do
    let(:campaign) { create(:campaign) }
    let(:campaign_url) { root_url(subdomain: campaign.url, host: 'lvh.me') }
    before do
      Capybara.app_host = campaign_url
    end
    scenario 'visitor comes to root_path' do
      visit campaign_url
      expect(evaluate_script('campaign')).to(
        eq(JSON.parse(Rabl::Renderer.json(campaign.decorate,
                                          'site/campaign',
                                          view_path: 'app/views')))
        )
    end
  end

  feature 'subdomain' do
    let(:campaign) { create(:subdomain_campaign) }
    let(:campaign_url) { root_url(subdomain: "#{campaign.url}", host: "#{ENV['base_url']}.lvh.me") }
    before do
      Capybara.app_host = campaign_url
    end
    scenario 'visitor comes to root_path' do
      visit campaign_url
      expect(evaluate_script('campaign')).to(
        eq(JSON.parse(Rabl::Renderer.json(campaign.decorate,
                                          'site/campaign',
                                          view_path: 'app/views')))
        )
    end
  end

  feature 'api url' do
    let(:campaign) { create(:campaign) }
    let(:campaign_url) { root_url(subdomain: campaign.url, host: 'lvh.me') }
    before do
      Capybara.app_host = campaign_url
    end
    scenario 'visitor comes to root_path' do
      visit campaign_url
      expect(evaluate_script('apiUrl')).to eq("//api.#{ENV['base_url']}:7171")
    end
  end
end
