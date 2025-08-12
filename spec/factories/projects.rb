FactoryBot.define do
  factory :project do
    association :client
    title { "Website Redesign" }
    status { 0 }             # 0 = pending
    price { "1500.00" }       
    due_date { Date.today + 30.days }
  end
end
