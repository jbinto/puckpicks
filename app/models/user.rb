class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true  
  validates :password, :presence => true, :on => :create
  validates_confirmation_of :password

  has_many :picks

  def pick_for(game)
    picks.where(:game_id => game.id).first
  end

  def score_since(since)
    picks.since(since).sum(:impact)
  end

  def score
    picks.sum(:impact)
  end
end
