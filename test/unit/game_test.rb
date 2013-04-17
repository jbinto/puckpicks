require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "game cannot have same teams" do
    team = FactoryGirl.build(:team)
    game = FactoryGirl.build(:game, home: team, away: team)
    refute game.valid?
  end


end
