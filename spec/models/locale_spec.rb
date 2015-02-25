require 'spec_helper'

RSpec.describe Locale, type: :model do
  # associations
  it { is_expected.to have_many(:alternate_locales).dependent(:destroy) }
  it { is_expected.to have_many(:locales).through(:alternate_locales) }

  # validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:code) }
end
