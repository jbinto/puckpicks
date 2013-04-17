require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test "team's full name is correct" do
    team = FactoryGirl.build(:team, :city => "Buffalo", :name => "Sabres")
    assert_equal "Buffalo Sabres", team.full_name
  end
end
