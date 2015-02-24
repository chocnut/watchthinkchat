require 'rails_helper'

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
    before { subject.stub(:translator?) { true } }
    it { is_expected.to validate_presence_of(:locale) }
  end
end
