require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "game cannot have same teams" do
    team = FactoryGirl.build(:team)
    game = FactoryGirl.build(:game, home: team, away: team)
    refute game.valid?
  end

  test "setting result finishes the game" do
    game = FactoryGirl.build(:game)
    game.set_result(winner: game.home, home_score: 5, away_score: 2)
    assert game.finished?
  end

  test "finished game must have scores and a winner" do
    game = FactoryGirl.build(:game, :finished => true)
    refute game.valid?

    assert game.errors[:winner].count > 0
    assert game.errors[:home_score].count > 0
    assert game.errors[:away_score].count > 0
  end

  test "winning team must be a team that played" do
    game = FactoryGirl.build(:finished_game, :winner => FactoryGirl.build(:team))
    refute game.valid?
    assert game.errors[:winner].count > 0
  end

end
