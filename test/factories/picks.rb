# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pick do
    game { FactoryGirl.build(:game) }
    team { game.home }
    user { FactoryGirl.build(:user) }
    spread_wager 1
    impact 0
  end
end
