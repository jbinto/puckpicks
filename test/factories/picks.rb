# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pick do
    game { FactoryGirl.build(:game) }
    team { game.home }
    user { FactoryGirl.build(:user) }
    spread_wager 1
    impact 0

    factory :decided_pick do
      game { FactoryGirl.build(:finished_game) }
      impact 1
    end
  end
end
