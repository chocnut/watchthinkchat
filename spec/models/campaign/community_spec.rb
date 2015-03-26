require 'spec_helper'

RSpec.describe Campaign::Community, type: :model do
  it { is_expected.to belong_to :campaign }
  it { is_expected.to validate_presence_of :campaign }
  context 'if enabled' do
    before { allow(subject).to receive_messages(enabled?: true) }
    context 'if other_campaign' do
      before { allow(subject).to receive_messages(other_campaign?: true) }
      it { is_expected.to validate_presence_of :child_campaign }
      it { is_expected.to_not validate_presence_of :url }
      it { is_expected.to_not ensure_length_of(:url).is_at_most(255) }
      it { is_expected.to_not validate_presence_of :title }
      it { is_expected.to_not validate_presence_of :description }
    end
    context 'if external site' do
      before { allow(subject).to receive_messages(other_campaign?: false) }
      it { is_expected.to_not validate_presence_of :child_campaign }
      it { is_expected.to validate_presence_of :url }
      it { is_expected.to ensure_length_of(:url).is_at_most(255) }
      it { is_expected.to validate_presence_of :title }
      it { is_expected.to validate_presence_of :description }
      it do
        is_expected.to_not allow_value('goober',
                                       '-',
                                       'google.com/path').for(:url)
      end
      it do
        is_expected.to allow_value('http://www.goober.com',
                                   'http://subdomain.example.com/rails',
                                   'https://mail.google.com/12/23/4/79?q=t',
                                   'http://valid.domain.museum/greg').for(:url)
      end
    end
  end
end
