FactoryGirl.define do
  factory :visitor, class: Visitor do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
  end
end
