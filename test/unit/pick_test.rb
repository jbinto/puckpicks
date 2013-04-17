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

  test "user can only bet on a single game once" do
    user = FactoryGirl.build(:user)
    game = FactoryGirl.build(:game)
    
    # We actually have to use create here, since we're testing uniqueness. 
    pick_home = FactoryGirl.create(:pick, :user => user, :game => game, :team => game.home)
    assert pick_home.valid?

    pick_away = FactoryGirl.build(:pick, :user => user, :game => game, :team => game.away)
    refute pick_away.valid?
  end

  test "two different users can bet on the same game" do
    user1 = FactoryGirl.build(:user)
    user2 = FactoryGirl.build(:user)
    game = FactoryGirl.build(:game)

    pick1 = FactoryGirl.build(:pick, :game => game, :user => user1)
    pick2 = FactoryGirl.build(:pick, :game => game, :user => user2)

    assert pick1.valid?
    assert pick2.valid?
  end

end
