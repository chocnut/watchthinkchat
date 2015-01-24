require 'rails_helper'

describe Dashboard::CampaignsController do
  let(:manager) { create(:manager) }
  before do
    sign_in(manager)
    @campaign = create(:campaign)
    manager.campaigns << @campaign
    @survey = create(:survey, campaign: @campaign)
    (0..1).each { |_n| create(:question, survey: @survey) }
  end

  describe '#index' do
    it 'renders the index template' do
      get :index, locale: :en
      expect(response).to render_template('index')
    end
  end
end
