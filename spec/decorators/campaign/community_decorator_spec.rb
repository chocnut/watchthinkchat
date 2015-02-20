require 'rails_helper'

describe Campaign::CommunityDecorator, type: :decorator do
  describe 'when other_campaign' do
    context 'is true' do
      let(:community) { build_stubbed(:community_other_campaign).decorate }
      it 'retrieves child_camapaign as permalink' do
        expect(community.permalink).to eq(community.child_campaign.permalink)
      end
      it 'retrieves display_title as campaign.name' do
        expect(community.display_title)
          .to eq(community.child_campaign.name)
      end
    end
    context 'is false' do
      let(:community) { build_stubbed(:community).decorate }
      it 'retrieves url as permalink' do
        expect(community.permalink).to eq(community.url)
      end
      it 'retrieves display_title as title' do
        expect(community.display_title).to eq(community.title)
      end
    end
  end
end
