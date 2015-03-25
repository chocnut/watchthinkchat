class InviteMailer < Devise::Mailer
  def translator_invitation_instructions(record, opts = {})
    load_invite(record)
    load_campaign
    load_inviter
    load_locale
    opts[:subject] = subject
    opts[:reply_to] = @invite.user.try(:email)
    devise_mail(record, :translator_invitation_instructions, opts)
  end

  protected

  def load_invite(record)
    @invite ||= record.invite
  end

  def load_campaign
    @campaign ||= @invite.try(:campaign).try(:decorate)
  end

  def load_inviter
    @inviter ||= @invite.try(:user).try(:decorate)
  end

  def load_locale
    @locale ||= @invite.try(:locale).try(:decorate)
  end

  def subject
    t('invite_mailer.header',
      inviter_name: @inviter.try(:name),
      campaign_name: @campaign.try(:name),
      locale_name: @locale.try(:name))
  end
end
