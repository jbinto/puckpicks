require 'test_helper'

class PickTest < ActiveSupport::TestCase
  test "user can make a pick" do    
    user = FactoryGirl.build(:user)
    game = FactoryGirl.build(:game)

    pick = FactoryGirl.build(:pick, 
      :user => user,
      :game => game,
      :spread_wager => 2,
      :team => game.home
    )

    assert pick.valid?
  end

  test "team selected must be playing in that game" do
    team1 = FactoryGirl.build(:team)
    team2 = FactoryGirl.build(:team)
    team3 = FactoryGirl.build(:team)

    game = FactoryGirl.build(:game, home: team1, away: team2)

    pick = FactoryGirl.build(:pick,
      :team => team3
    )

    # Team selected must be playing in that game
    refute pick.valid?
    assert pick.errors[:team].count == 1
  end

end
