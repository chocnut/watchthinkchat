module VisitorInvite
  class Inviter < ActiveType::Record[Visitor]
    has_many :invitations, class_name: 'Visitor::Invitation'
    has_many :invitees,
             through: :invitations,
             class_name: 'VisitorInvite::Invitee'
  end
end
