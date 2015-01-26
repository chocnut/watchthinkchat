FactoryGirl.define do
  factory :growthspace, class: 'Campaign::Growthspace' do
    campaign
    enabled true
    title 'MyString'
  end
end
