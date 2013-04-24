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

end
