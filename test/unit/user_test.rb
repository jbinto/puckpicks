require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "email and username must be unique" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.build(:user, :username => user1.username)

    refute user2.save

    already_taken = "has already been taken"
    assert user2.errors.messages[:email] = already_taken
    assert user2.errors.messages[:username] = already_taken
  end

  test "user's total score starts at 0" do
    user = FactoryGirl.create(:user)
    assert_equal 0, user.score
  end

  test "user's total score is calculatable" do
    user = FactoryGirl.create(:user)
    picks = 5.times { FactoryGirl.create(:decided_pick, :user => user) }
    assert_equal 5, user.score
  end

  test "user's total score is calculatable since a date" do
    user = FactoryGirl.create(:user)

    games = []
    games += 2.times.map { FactoryGirl.create(:game, :faceoff_time => 3.weeks.ago) }
    games += 2.times.map { FactoryGirl.create(:game, :faceoff_time => 1.day.ago) }

    games.each do |game|
      pick = FactoryGirl.build(:decided_pick, game: game, user: user)

      # need to skip validation, otherwise it complains game has already finished
      pick.save(:validate => false)
    end

    assert_equal 2, user.score_since(2.days.ago)

  end

end
