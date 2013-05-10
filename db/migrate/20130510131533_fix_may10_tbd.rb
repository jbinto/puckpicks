class FixMay10Tbd < ActiveRecord::Migration
  def up
    ana = Team.find_by_code("ANA")
    det = Team.find_by_code("DET")
    
    Game.transaction do
      # Game 6 @ DET
      game = Game.where(:away_id => ana.id, :home_id => det.id, :faceoff_time => Time.zone.parse("FRI MAY 10 2013 11:11AM ET")).first
      game.faceoff_time = Time.zone.parse("FRI MAY 10 2013 8:00PM ET")
      game.save!
    end

    stl = Team.find_by_code("STL")
    la = Team.find_by_code("LA")

    Game.transaction do
      # Game 6 @ LA
      game = Game.where(:away_id => stl.id, :home_id => la.id, :faceoff_time => Time.zone.parse("FRI MAY 10 2013 11:11AM ET")).first
      game.faceoff_time = Time.zone.parse("FRI MAY 10 2013 10:00PM ET")
      game.save!
    end

  end

  def down
  end
end
