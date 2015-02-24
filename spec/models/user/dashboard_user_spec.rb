require 'rails_helper'

RSpec.describe User::DashboardUser, type: :model do
  subject { User::DashboardUser.abstract_class }
  it { is_expected.to eq(true) }
end
