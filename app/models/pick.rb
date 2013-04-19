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

  # Note: This was tricky. Can't use :game and :user here due
  # to some quirks in Rails.
  #
  # See http://thetenelements.blogspot.ca/2011/08/undefined-method-text-for-nilnilclass.html?showComment=1366233346425#c3603757500714800844
  # and http://stackoverflow.com/a/7032711/19779 for more.
  validates_uniqueness_of :game_id, :scope => :user_id,
    message: "You can only bet on this game once."

  # note XXX: even if I drop the `on create`, all of our tests pass. 
  # There may be bugs lurking here.
  validate :game_must_be_in_future, :on => :create

  scope :decided, where("impact != 0")
  scope :pending, where("impact == 0")

  def decide
    return false if decided?
    return false unless game.finished?

    if spread_covered
      self.impact = self.spread_wager
    else
      self.impact = 0 - self.spread_wager
    end

    true
  end

  def spread_covered
    return false unless game.winner == team
    return true if spread_wager == 1

    # spread_wager was >1, see if the spread was covered
    spread = game.winner_score - game.loser_score
    return spread >= spread_wager
  end

  def decided?
    impact != 0
  end

  protected
  def game_must_be_in_future
    # note: Will this cause problems when we need to update the pick for impact?
    # The tests seem to pass, but this doesn't really make sense.
    if game.started?
      errors.add(:game, "must not have already started")
    end
  end
end
