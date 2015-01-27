require 'visitor'
class Visitor
  class InvitationDecorator < Draper::Decorator
    delegate_all
    decorates_association :invitee
    decorates_association :inviter
    decorates_association :campaign

    def url
      "#{campaign.permalink}/#{I18n.locale}/i/#{token}"
    end
  end
end
