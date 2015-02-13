require 'rails_helper'

describe 'Campaign Builder', type: :feature, js: true do
  let(:manager) { create(:manager) }
  let(:base_locale) { create(:locale, name: 'base', code: 'fr') }
  let(:alternate_locale) { create(:locale, name: 'available', code: 'de') }

  before do
    Warden.test_mode!
    Capybara.app_host = "http://app.#{ENV['base_url']}.lvh.me:7171"
    login_as(manager, scope: :user)
    base_locale.save!
    alternate_locale.save!
    page.driver.allow_url "app.#{ENV['base_url']}.lvh.me"
    page.driver.allow_url 'use.typekit.net'
    page.driver.allow_url 'www.google.com'
    page.driver.allow_url 's.ytimg.com'
    page.driver.allow_url 'www.youtube.com'
    page.driver.allow_url "app.#{ENV['base_url']}"
  end

  feature 'build campaign' do
    given(:campaign) { create(:campaign) }
    background do
      create(:permission,
             user: manager,
             state: Permission.states[:owner],
             resource: campaign)
    end
    scenario 'basic page' do
      expect { visit new_campaign_path(locale: :en) }.to change(Campaign, :count).by(1)
      campaign_attributes = attributes_for(:campaign)
      fill_in 'campaign[name]', with: campaign_attributes[:name]
      select 'French', from: 'campaign[locale_id]'
      fill_in 'campaign[url]', with: campaign_attributes[:url]
      choose 'CNAME address'
      click_button 'Next'
      expect(current_path).to eq(campaign_build_path(Campaign.last.id,
                                                     :engagement_player))
    end
    scenario 'engagement player page' do
      campaign.engagement_player!
      engagement_player_attributes = attributes_for(:engagement_player)
      visit campaign_build_path(campaign, :engagement_player, locale: :en)
      choose 'On'
      click_button 'Next'
      find '#campaign_engagement_player_attributes_media_link.error'
      fill_in 'campaign[engagement_player_attributes][media_link]',
              with: engagement_player_attributes[:media_link]
      fill_in 'campaign[engagement_player_attributes][media_start]',
              with: '0'
      fill_in 'campaign[engagement_player_attributes][media_stop]',
              with: '10'
      click_button 'Next'
      expect(current_path).to eq(campaign_build_path(campaign,
                                                     :growthspace))
    end
    scenario 'growthspace page' do
      campaign.growthspace!
      growthspace_attributes = attributes_for(:growthspace)
      visit campaign_build_path(campaign, :growthspace, locale: :en)
      choose 'On'
      click_button 'Next'
      find '#campaign_growthspace_attributes_title.error'
      fill_in 'campaign[growthspace_attributes][title]',
              with: growthspace_attributes[:title]
      click_button 'Next'
      expect(current_path).to eq(campaign_build_path(campaign,
                                                     :survey))
    end
    scenario 'survey page' do
      campaign.survey!
      visit campaign_build_path(campaign, :survey)
      expect do
        wait_until_angular_ready
        fill_in 'new_question_title', with: 'Will you follow me?'
        fill_in 'new_option_text', with: 'Yes'
        select 'Continue', from: 'new_conditional'
        click_button 'Add Question'
        page
      end.to change(Campaign::Survey::Question, :count).by(1)
      click_button 'Next'
      expect(current_path).to eq(campaign_build_path(campaign,
                                                     :share))
    end
    scenario 'share page' do
      campaign.share!
      share_attributes = attributes_for(:share)
      visit campaign_build_path(campaign, :share)
      choose 'On'
      fill_in 'campaign[share_attributes][title]',
              with: share_attributes[:title]
      fill_in 'campaign[share_attributes][description]',
              with: share_attributes[:description]
      click_button 'Next'
      expect(current_path).to eq(campaign_build_path(campaign,
                                                     :community))
    end
    scenario 'community page' do
      campaign.community!
      community_attributes = attributes_for(:community)
      visit campaign_build_path(campaign, :community)
      choose 'On'
      click_button 'Next'
      find '#campaign_community_attributes_other_campaign_input.error'
      choose 'Campaign'
      click_button 'Next'
      find '#campaign_community_attributes_child_campaign_input.error'
      choose 'URL'
      click_button 'Next'
      find '#campaign_community_attributes_url.error'
      fill_in 'campaign[community_attributes][url]',
              with: community_attributes[:url]
      find '#campaign_community_attributes_title.error'
      fill_in 'campaign[community_attributes][title]',
              with: community_attributes[:title]
      find '#campaign_community_attributes_description.error'
      fill_in 'campaign[community_attributes][description]',
              with: community_attributes[:description]
      click_button 'Next'
      expect(current_path).to eq(campaign_build_path(campaign,
                                                     :opened))
    end
  end

  after do
    Warden.test_reset!
  end
end
