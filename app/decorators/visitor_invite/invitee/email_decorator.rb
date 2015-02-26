# rubocop:disable Style/ClassAndModuleChildren
class VisitorInvite::Invitee::EmailDecorator < Draper::Decorator
  delegate_all
  decorates_association :invitation

  def to
    invitee.email
  end

  def from
    inviter.email
  end
end
# rubocop:enable Style/ClassAndModuleChildren
