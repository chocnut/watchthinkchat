require 'spec_helper'

RSpec.describe Visitor, type: :model do
  # associations
  it { is_expected.to have_many(:interactions).dependent(:destroy) }
  it { is_expected.to have_db_column(:share_token) }
  it { is_expected.to have_db_index(:share_token) }
  it { is_expected.to have_db_column(:authentication_token) }
  it { is_expected.to have_db_index(:authentication_token) }
  it { is_expected.to have_db_column(:notify_inviter).of_type(:boolean) }
  it { is_expected.to have_db_column(:notify_me_on_share).of_type(:boolean) }
  # definitions
  describe '#as' do
    let(:visitor) { build_stubbed(:visitor) }
    context ':inviter' do
      it 'returns inviter object' do
        expect(visitor.as(:inviter)).to be_a(VisitorInvite::Inviter)
      end
    end
    context ':invitee' do
      it 'returns invitee object' do
        expect(visitor.as(:invitee)).to be_a(VisitorInvite::Invitee)
      end
    end
  end
end
