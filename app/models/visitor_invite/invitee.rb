module VisitorInvite
  class Invitee < ActiveType::Record[Visitor]
    has_many :invitations, class_name: 'Visitor::Invitation'
    has_many :inviters,
             through: :invitations,
             class_name: 'VisitorInvite::Inviter'
  end
end
