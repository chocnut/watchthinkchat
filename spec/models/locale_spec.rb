require 'rails_helper'

RSpec.describe Locale, type: :model do
  # associations
  it { is_expected.to have_many(:alternate_locales).dependent(:destroy) }
  it { is_expected.to have_many(:locales).through(:alternate_locales) }

  # validations
  it 'is invalid without code' do
    expect(build(:locale, code: nil)).not_to be_valid
  end
  it 'is invalid without name' do
    expect(build(:locale, name: nil)).not_to be_valid
  end
end
