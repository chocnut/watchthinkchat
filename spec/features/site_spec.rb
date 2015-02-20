require 'rails_helper'

describe 'Site', type: :feature, js: true do
  feature 'cname' do
    let(:campaign) { create(:campaign) }
    before do
      Capybara.app_host = "http://#{campaign.url}.lvh.me"
    end
    scenario 'visitor comes to root_path' do
      visit root_path
      expect(evaluate_script('campaign')).to(
        eq(JSON.parse(Rabl::Renderer.json(campaign.decorate,
                                          'site/campaign',
                                          view_path: 'app/views')))
        )
    end
  end

  feature 'subdomain' do
    let(:campaign) { create(:subdomain_campaign) }
    before do
      Capybara.app_host =
        "http://#{campaign.url}.#{ENV['base_url']}.lvh.me"
    end
    scenario 'visitor comes to root_path' do
      visit root_path
      expect(evaluate_script('campaign')).to(
        eq(JSON.parse(Rabl::Renderer.json(campaign.decorate,
                                          'site/campaign',
                                          view_path: 'app/views')))
        )
    end
  end

  feature 'api url' do
    let(:campaign) { create(:campaign) }
    before do
      Capybara.app_host = "http://#{campaign.url}.lvh.me"
    end
    scenario 'visitor comes to root_path' do
      visit root_path
      expect(evaluate_script('apiUrl')).to eq("http://api.#{ENV['base_url']}")
    end
  end
end
