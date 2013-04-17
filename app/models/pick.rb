class Pick < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  belongs_to :user
  attr_accessible :spread_wager, :game, :team

  validates :game, :presence => true
  validates :team, :presence => true
  validates :user, :presence => true
  validates :spread_wager, :presence => true

  validate :team_picked_must_be_playing

  def team_picked_must_be_playing
    unless [game.home, game.away].include?(team)
      errors.add(:team, "must be playing in this game")
    end
  end
end
