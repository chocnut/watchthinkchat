require 'rails_helper'

describe UserDecorator, type: :decorator do
  let(:available_locale) { create(:available_locale).decorate }

  it '#permissions returns array of permissions for this locale' do
    @user = create(:user)
    @permission = Permission.create(resource: available_locale.campaign,
                                    locale: available_locale.locale,
                                    state: Permission.states[:translator],
                                    user: @user)
    expect(available_locale.permissions.first).to eq(@permission)
  end
end
