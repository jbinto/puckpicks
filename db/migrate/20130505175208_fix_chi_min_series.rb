class FixChiMinSeries < ActiveRecord::Migration
  def up
    min = Team.find_by_code("MIN")
    chi = Team.find_by_code("CHI")
    
    Game.transaction do
      # Game 3 @ MIN
      game = Game.where(:home_id => min.id, :away_id => chi.id, :faceoff_time => Time.zone.parse("SAT MAY 4, 2013 3:00PM")).first
      game.faceoff_time = Time.zone.parse("SUN MAY 5, 2013 3:00 PM ET")
      game.save!
      
      # Game 4 @ MIN
      game = Game.where(:home_id => min.id, :away_id => chi.id, :faceoff_time => Time.zone.parse("MON MAY 6, 2013 9:30PM ET")).first
      game.faceoff_time = Time.zone.parse("TUE MAY 7, 2013 9:30PM ET")
      game.save!

      # Game 5 @ CHI
      game = Game.where(:away_id => min.id, :home_id => chi.id, :faceoff_time => Time.zone.parse("WED MAY 8, 2013 11:11AM ET")).first
      game.faceoff_time = Time.zone.parse("THU MAY 9, 2013 11:11AM ET")
      game.save!

      # Game 6 @ MIN
      game = Game.where(:home_id => min.id, :away_id => chi.id, :faceoff_time => Time.zone.parse("FRI MAY 10, 2013 11:11AM ET")).first
      game.faceoff_time = Time.zone.parse("SAT MAY 11, 2013 11:11AM ET")
      game.save!
    end

  end


  def down
  end
end
