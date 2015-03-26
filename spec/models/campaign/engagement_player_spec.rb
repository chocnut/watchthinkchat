require 'spec_helper'

RSpec.describe Campaign::EngagementPlayer, type: :model do
  it { is_expected.to belong_to :campaign }
  it { is_expected.to validate_presence_of :campaign }
  context 'if enabled' do
    before { allow(subject).to receive_messages(enabled?: true) }
    it { is_expected.to validate_presence_of(:media_link) }
  end
  context 'if disabled' do
    before { allow(subject).to receive_messages(enabled?: false) }
    it { is_expected.to_not validate_presence_of(:media_link) }
  end
end
