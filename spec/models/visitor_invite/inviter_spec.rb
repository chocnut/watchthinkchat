require 'spec_helper'

RSpec.describe VisitorInvite::Inviter, type: :model do
  # associations
  it { is_expected.to have_many(:invitations) }
  it { is_expected.to have_many(:invitees).through(:invitations) }
end
