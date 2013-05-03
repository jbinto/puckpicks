class FixGame750Date < ActiveRecord::Migration
  def up
    min = Team.find_by_code("MIN")
    chi = Team.find_by_code("CHI")
    game = Game.where(:away_id => min.id, :home_id => chi.id, :faceoff_time => Time.zone.parse("THU MAY 2, 2013 9:30PM")).first
    if game
      game.faceoff_time = Time.zone.parse("FRI MAY 3, 2013 9:30 PM ET")
      game.save
    else
      puts "Couldn't find game"
    end
  end

  def down
  end
end
