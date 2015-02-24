require 'rails_helper'

RSpec.describe Campaign::EngagementPlayer, type: :model do
  it { is_expected.to belong_to :campaign }
  it { is_expected.to validate_presence_of :campaign }
  context 'if enabled' do
    before { subject.stub(:enabled?) { true } }
    it { is_expected.to validate_presence_of(:media_link) }
  end
  context 'if disabled' do
    before { subject.stub(:enabled?) { false } }
    it { is_expected.to_not validate_presence_of(:media_link) }
  end
end
