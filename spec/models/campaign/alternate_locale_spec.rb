require 'spec_helper'

RSpec.describe Campaign::AlternateLocale, type: :model do
  # associations
  it { is_expected.to belong_to :campaign }
  it { is_expected.to belong_to :locale }

  # validations
  it { is_expected.to validate_presence_of :campaign }
  it { is_expected.to validate_presence_of :locale }
end
