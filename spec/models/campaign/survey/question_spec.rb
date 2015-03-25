require 'spec_helper'

RSpec.describe Campaign::Survey::Question, type: :model do
  it { is_expected.to validate_presence_of :survey }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to have_many(:options).dependent(:destroy) }
  it do
    is_expected.to accept_nested_attributes_for(:options).allow_destroy(true)
  end
  describe '#code' do
    before { allow(subject).to receive_messages(id: 123) }
    it 'returns correct code' do
      expect(subject.code).to eq(Base62.encode(subject.id))
    end
  end
end
