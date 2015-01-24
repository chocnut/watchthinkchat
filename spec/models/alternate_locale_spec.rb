require 'rails_helper'

RSpec.describe AlternateLocale, type: :model do
  # associations
  it { is_expected.to belong_to :campaign }
  it { is_expected.to belong_to :locale }

  # validations
  it { is_expected.to validate_presence_of :campaign }
  it { is_expected.to validate_presence_of :locale }

  # parent objects
  it 'is destroyed when campaign is destroyed' do
    @alternate_locale = create(:alternate_locale)
    @alternate_locale.campaign.destroy!
    expect { @alternate_locale.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
  it 'is destroyed when locale is destroyed' do
    @alternate_locale = create(:alternate_locale)
    @alternate_locale.locale.destroy!
    expect { @alternate_locale.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
