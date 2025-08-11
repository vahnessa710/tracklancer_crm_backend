FactoryBot.define do
    factory :user do
      email { "user@email.com" } # Default, override in tests when needed
      password { "password" }
      password_confirmation { "password" }
    end
end