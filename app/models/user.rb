class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :username, :email, :password, :password_confirmation

  validates :username, :presence => true, :uniqueness => true
  validates :email, :presence => true, :uniqueness => true  
  validates :password, :presence => true, :on => :create
  validates_confirmation_of :password

  has_many :picks

  def score_since(since)
    picks.since(since).sum(:impact)
  end

  def score
    picks.sum(:impact)
  end

  def self.leaders
    leaders = User.joins(:picks).select("users.username, sum(impact) as points").group("users.username").order("points desc").all
    
    position = 0
    leaders.map { |l| {position: position+=1, username: l.username, points: l.points } }
    
    # Calculating leaderboards is a bit of a challenge. My thoughts:

    # 1) The naive approach is to just iterate through User.all and call the score method, but this is inefficient, it will do an N+1 query.:
      # SELECT * FROM USERS
      # SELECT SUM(impact) FROM PICKS WHERE USER_ID=1
      # SELECT SUM(impact) FROM PICKS WHERE USER_ID=2
      # ....

    # 2) The code above works, but it's sketchy. It drops too deep into SQL for my liking. It also returns an ActiveRecord User, which is
    #    totally misleading. Only the username attribute is selected, so everything else is nil. It also means I can't call the "score" 
    #    field "score", since there's already a method by that name! Thus "points".  To work around the "returns a not-quite-User-object"
    #    problem, I just map it into an array of hashes.

    # 3) This is completely untestable and 100% coupled to my database. Is that okay? What if I wanted to introduce tiebreakers (e.g.
    #    the user with the more correct picks regardless of spread). It's probably possible with juggling SQL, but how do I unit test
    #    this?

  end
end
