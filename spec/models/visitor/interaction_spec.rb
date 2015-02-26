require 'spec_helper'

RSpec.describe Visitor::Interaction, type: :model do
  subject { build_stubbed(:interaction) }
  # associations
  it { is_expected.to belong_to(:campaign) }
  it { is_expected.to have_db_index(:campaign_id) }
  it { is_expected.to belong_to(:resource) }
  it { is_expected.to have_db_index(:resource_id) }
  it { is_expected.to belong_to(:visitor) }
  it { is_expected.to have_db_index(:visitor_id) }

  # validations
  it { is_expected.to validate_presence_of(:campaign) }
  it { is_expected.to validate_presence_of(:resource) }
  it { is_expected.to validate_presence_of(:visitor) }
  it { is_expected.to validate_presence_of(:action) }

  # definitions
  it do
    is_expected.to define_enum_for(:action).with([:start,
                                                  :finish,
                                                  :click])
  end
  it { is_expected.to serialize(:data) }
  context 'if resource not related to campaign' do
    before { subject.stub(:resource) { build_stubbed(:campaign) } }
    it { is_expected.to_not be_valid }
  end
end
