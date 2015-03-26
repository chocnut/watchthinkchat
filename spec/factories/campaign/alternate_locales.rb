FactoryGirl.define do
  factory :alternate_locale, class: Campaign::AlternateLocale do
    campaign
    locale
  end
end
