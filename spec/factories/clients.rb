FactoryBot.define do
  factory :client do
    association :user
    sequence(:name)  { |n| "Client #{n}" }
    sequence(:email) { |n| "client#{n}@example.com" }
    phone { "1234567890" }
    company_name { "Company #{rand(100)}" }
  end
end
