require 'rails_helper'

describe 'Campaign Builder', type: :feature do
  let(:manager) { create(:manager) }

  before do
    Warden.test_mode!
    Capybara.app_host = "http://app.#{ENV['base_url']}"
    login_as(manager, scope: :user)
  end

  feature 'Campaigns' do
    scenario 'no campaign index' do
      visit campaigns_path
      expect(page).to have_content('Start Creating')
      expect(page).to have_content('Create a New Campaign')
    end
  end

  after do
    Warden.test_reset!
  end
end
