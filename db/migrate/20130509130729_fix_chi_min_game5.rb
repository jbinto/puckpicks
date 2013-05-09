class FixChiMinGame5 < ActiveRecord::Migration
  def up
    min = Team.find_by_code("MIN")
    chi = Team.find_by_code("CHI")
    
    Game.transaction do
      # Game 5 @ CHI
      game = Game.where(:away_id => min.id, :home_id => chi.id, :faceoff_time => Time.zone.parse("THU MAY 9, 2013 11:11AM ET")).first
      game.faceoff_time = Time.zone.parse("THU MAY 9, 2013 9:30PM ET")
      game.save!
    end

  end

  def down
  end
end
