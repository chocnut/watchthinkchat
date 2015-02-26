FactoryGirl.define do
  factory :campaign do
    sequence(:name) { |n| "campaign_#{n}" }
    status Campaign.statuses[:opened]
    url  { Faker::Internet.domain_name }
    subdomain false
    locale
    intro { Faker::Lorem.sentence }
    description { Faker::Hacker.say_something_smart }
    factory :subdomain_campaign do
      url { Faker::Internet.domain_word }
      subdomain true
    end
  end
end
