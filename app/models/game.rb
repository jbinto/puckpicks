class Game < ActiveRecord::Base
  # This was tricky. Things that didn't work:

  # 1) Using "home:references" with the rails generator. That just assumes there's a home_table with a home_id.
  # 2) Using "has_one :home". That assumes the table "home" will have a "game_id" (?????????????)

  belongs_to :home, :class_name => "Team"
  belongs_to :away, :class_name => "Team"
  belongs_to :winner, :class_name => "Team"

  validate :cannot_be_same_teams

  def cannot_be_same_teams
    if home == away
      errors.add(:away, "can't be same as home")
      errors.add(:home, "can't be same as away")
    end
  end
end
