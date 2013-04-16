# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "thegreatone"
    email "thegreatone@example.org"
    password "abc123"
  end
end
