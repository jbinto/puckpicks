class Pick < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :user
  attr_accessible :spread_wager, :game, :team

  validates :game, :presence => true
  validates :team, :presence => true
  validates :user, :presence => true
  validates :spread_wager, :presence => true

  validates :team, :inclusion => { 
    :in => lambda { |pick| [pick.game.home, pick.game.away] },
    :message => "The team picked must be playing in the game."
  }

  validates_uniqueness_of :game_id, :scope => :user_id,
    message: "You can only bet on this game once."
end
