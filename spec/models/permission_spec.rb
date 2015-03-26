require 'spec_helper'

RSpec.describe Permission, type: :model do
  # associations
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:resource) }
  it { is_expected.to belong_to(:locale) }

  # validations
  it { is_expected.to validate_presence_of(:resource) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:state) }
  context 'if state is translator' do
    before { allow(subject).to receive_messages(translator?: true) }
    it { is_expected.to validate_presence_of(:locale) }
  end
end
