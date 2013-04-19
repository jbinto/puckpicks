class Game < ActiveRecord::Base

  # Starting to see through the Rails magic here. Things I learned:
  #
  # 1) Creating a migration or generating a model has nothing to do with associations.
  # 2) Even if you use foo:references, all that does is create a foo_id on the table.
  # 3) The relationships do *not* need to be symmetrical. I don't need a "has_many :games"
  #    on team.
  # 4) Setting "belongs_to" below just says: "look on this table (Game) for a home_id column,
  #    and look in Team.id to find it.

  belongs_to :home, :class_name => "Team"
  belongs_to :away, :class_name => "Team"
  belongs_to :winner, :class_name => "Team"

  # Required fields
  validates :home, :presence => true
  validates :away, :presence => true
  validates :faceoff_time, :presence => true

  # Cannot be the same teams
  validates :away, :exclusion => { 
    :in => lambda { |game| [game.home] },
    :message => "The away team can't be the same as the home team"
  }
  validates :home, :exclusion => { 
    :in => lambda { |game| [game.away] },
    :message => "The home team can't be the same as the away team"
  }

  # Required fields for finished games
  validates :winner, :presence => true, :if => :finished?
  validates :home_score, :presence => true, :if => :finished?
  validates :away_score, :presence => true, :if => :finished?

  # Team that won must have played.
  validates :winner, :if => :finished?, :inclusion => {
    :in => lambda { |game| [game.home, game.away] },
    :message => "The winning team must be either the home or away team"
  }

  # Winning team must have a greater score than the losing team.
  validate :winner_has_greater_score, :if => :finished?

  # Games for "today"
  scope :today, :conditions => ['faceoff_time >= ? AND faceoff_time <= ?', Date.today.beginning_of_day, Date.today.end_of_day]

  # Thought: Rather than using attr_accessible, we can use a 
  # special method here not accessible to the general public?
  def set_result(opts)
    self.winner = opts[:winner]
    self.home_score = opts[:home_score]
    self.away_score = opts[:away_score]
    self.finished = true
  end

  def winner_score
    return nil unless finished?
    home == winner ? home_score : away_score
  end

  def loser_score
    return nil unless finished?
    home != winner ? home_score : away_score
  end

  def friendly_text
    "#{faceoff_time}: #{away.name} at #{home.name}"
  end

  def started?
    Time.zone.now >= faceoff_time
  end

  protected
  def winner_has_greater_score
    # note: Other validations ensure that if a game is finished, there
    # must be a score. But this validation will also be called, and throw
    # a nil exception. To make testing possible we need this compromise.

    # Not the prettiest way to do it, but I really want to be sure that
    # a "finished?" game has certain attributes.

    return unless finished? && winner_score && loser_score

    message = "Winning team must have a greater score than losing team"
    if winner_score <= loser_score
      errors.add(:winner, message)
    end
  end
end
