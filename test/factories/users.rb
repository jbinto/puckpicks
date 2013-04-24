# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "thegreatone#{n}" }
    sequence(:email) { |n| "thegreatone#{n}@example.org" }
    password "abc123"
  end
end
