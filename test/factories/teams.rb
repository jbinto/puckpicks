# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    sequence(:code) { |n| "HT#{n}" }
    sequence(:city) { |n| "City #{n} " }
    name "Hockey Team"
    logo { "#{code}.png" }
  end
end
