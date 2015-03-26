require 'rails_helper'

RSpec.describe Campaign::Survey::Question::Option, type: :model do
  it { is_expected.to belong_to :question }
  it { is_expected.to belong_to :route }
  it { is_expected.to belong_to :conditional_question }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :conditional }
  context 'if conditional is skip' do
    before { allow(subject).to receive_messages(skip?: true) }
    it { is_expected.to validate_presence_of :conditional_question }
  end
  describe '#code' do
    before { allow(subject).to receive_messages(id: 123) }
    it 'returns correct code' do
      expect(subject.code).to eq(Base62.encode(subject.id))
    end
  end
end
