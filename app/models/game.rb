class Game < ActiveRecord::Base
  # This was tricky. Things that didn't work:

  # 1) Using "home:references" with the rails generator. That just assumes there's a home_table with a home_id.
  # 2) Using "has_one :home". That assumes the table "home" will have a "game_id" (?????????????)

  belongs_to :home, :class_name => "Team"
  belongs_to :away, :class_name => "Team"
  belongs_to :winner, :class_name => "Team"

  #validate :cannot_be_same_teams

  validates :away, :exclusion => { :in => lambda { |game| [game.home] } }

  validates :home, :presence => true
  validates :away, :presence => true
  validates :faceoff_time, :presence => true

  validates :winner, :presence => true, :if => :finished?
  validates :home_score, :presence => true, :if => :finished?
  validates :away_score, :presence => true, :if => :finished?

  def cannot_be_same_teams
    if home == away
      errors.add(:away, "can't be same as home")
      errors.add(:home, "can't be same as away")
    end
  end

  # Thought: Rather than using attr_accessible, we can use a 
  # special method here not accessible to the general public?
  def set_result(opts)
    self.winner = opts[:winner]
    self.home_score = opts[:home_score]
    self.away_score = opts[:away_score]
    self.finished = true
  end
end
