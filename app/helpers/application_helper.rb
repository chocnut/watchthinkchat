module ApplicationHelper
  def language_code(locale = I18n.locale)
    locale.to_s.split('-')[0]
  end
end
