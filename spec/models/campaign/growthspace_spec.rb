require 'rails_helper'

RSpec.describe Campaign::Growthspace, type: :model do
  it 'is invalid without an enabled' do
    expect(build(:growthspace, enabled: nil)).not_to be_valid
  end
  it 'is invalid without a title' do
    expect(build(:growthspace, title: nil)).not_to be_valid
  end
  it 'is invalid without a campaign' do
    expect(build(:growthspace, campaign: nil)).not_to be_valid
  end
  it 'creates a translation object when title is set' do
    @growthspace = create(:growthspace)
    expect(@growthspace.translations.where title: @growthspace.title).to exist
  end
end
