FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    token "example token"
    name "User"
    password "password"
  end
end
