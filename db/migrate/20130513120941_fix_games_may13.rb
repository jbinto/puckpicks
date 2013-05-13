class FixGamesMay13 < ActiveRecord::Migration
  def up
    Game.transaction do
      fix_tor_bos_times!
      fix_nyr_wsh_times!      
    end
  end

  def down
  end

  def fix_tor_bos_times!
    tor = Team.find_by_code("TOR")
    bos = Team.find_by_code("BOS")

    game = Game.where(:away_id => tor.id, :home_id => bos.id, :faceoff_time => Time.zone.parse("MON MAY 13, 2013 11:11AM ET")).first
    game.faceoff_time = Time.zone.parse("MON MAY 13 2013 7:00PM ET")
    game.save!
  end

  def fix_nyr_wsh_times!
    nyr = Team.find_by_code("NYR")
    wsh = Team.find_by_code("WSH")

    game = Game.where(:away_id => nyr.id, :home_id => wsh.id, :faceoff_time => Time.zone.parse("MON MAY 13, 2013 12:00PM ET")).first
    game.faceoff_time = Time.zone.parse("MON MAY 13 2013 8:00PM ET")
    game.save!
  end
end
