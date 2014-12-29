class AlternateLocaleDecorator < Draper::Decorator
  delegate_all

  def permissions
    Permission.where(resource: campaign,
                     locale: locale,
                     state: Permission.states[:translator]).all
  end
end
