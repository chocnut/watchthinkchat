require 'rails_helper'

RSpec.describe Campaign::Growthspace, type: :model do
  it { is_expected.to belong_to :campaign }
  it { is_expected.to validate_presence_of :campaign }
  it { is_expected.to validate_presence_of :title }
end
