require 'rails_helper'

describe Campaign::AlternateLocaleDecorator, type: :decorator do
  let(:alternate_locale) { create(:alternate_locale).decorate }

  it '#permissions returns array of permissions for this locale' do
    @user = create(:user)
    @permission = Permission.create(resource: alternate_locale.campaign,
                                    locale: alternate_locale.locale,
                                    state: Permission.states[:translator],
                                    user: @user)
    expect(alternate_locale.permissions.first).to eq(@permission)
  end
end
