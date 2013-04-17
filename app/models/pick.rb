class Pick < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :user
  attr_accessible :impact, :spread_wager
end
