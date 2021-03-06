require 'spec_helper'

RSpec.describe VisitorInvite::Invitee, type: :model do
  # associations
  it { is_expected.to have_many(:invitations) }
  it { is_expected.to have_db_column(:notify_inviter).of_type(:boolean) }
  it { is_expected.to have_many(:inviters).through(:invitations) }
end
