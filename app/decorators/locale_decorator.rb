class LocaleDecorator < Draper::Decorator
  include CountriesAndLanguages::Helpers
  delegate_all

  def name
    returnable = "#{language_string} #{country_string}".strip
    returnable = object.name if returnable.blank?
    returnable
  end

  def language_string
    language(code.split('-')[0]).titleize
  end

  def country_string
    return if country(country_code).blank?
    "(#{country(country_code).titleize})"
  end

  def country_code
    code.split('-')[1]
  end
end
