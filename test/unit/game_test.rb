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

  test "winning teams score must be greater than losing teams score" do
    game = FactoryGirl.build(:finished_game, away_score: 5, home_score: 2)    
    refute game.valid?
    assert game.errors[:winner].count > 0
  end

  test "winner_score, loser_score are nil when not finished" do
    game = FactoryGirl.build(:game)
    assert_nil game.winner_score
    assert_nil game.loser_score
  end

  test "winner_score, loser_score" do
    game = FactoryGirl.build(:finished_game, home_score: 10, away_score: 0)
    assert_equal 10, game.winner_score
    assert_equal 0, game.loser_score
  end

  test "after faceoff time, game is started" do
    game = FactoryGirl.create(:game, :faceoff_time => 2.hours.ago)
    assert game.started?
  end

  test "before faceoff time, game is not started" do
    game = FactoryGirl.create(:game, :faceoff_time => 2.hours.from_now)
    refute game.started?
  end

  test "boxscore can be retrieved when game is finished" do
    TOR = FactoryGirl.create(:team, :code => "TOR")
    OTT = FactoryGirl.create(:team, :code => "OTT")
    game = FactoryGirl.create(:finished_game, :home => TOR, :away => OTT, :home_score => 5, :away_score => 2)
    assert_equal "OTT 2 - TOR 5", game.boxscore
  end

end
