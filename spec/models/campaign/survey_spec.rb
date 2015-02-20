require 'spec_helper'

RSpec.describe Campaign::Survey, type: :model do
  it { is_expected.to belong_to :campaign }
  it { is_expected.to validate_presence_of :campaign }
  it { is_expected.to validate_presence_of :enabled }
  it { is_expected.to have_many(:questions).dependent(:destroy) }
  it do
    is_expected.to accept_nested_attributes_for(:questions).allow_destroy(true)
  end
end
