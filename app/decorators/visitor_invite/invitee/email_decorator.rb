require 'visitor_invite/invitee'
module VisitorInvite
  class Invitee
    class EmailDecorator < Draper::Decorator
      delegate_all
      decorates_association :invitation

      def to
        invitee.email
      end

      def from
        inviter.email
      end
    end
  end
end
