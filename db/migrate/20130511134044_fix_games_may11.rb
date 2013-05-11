class FixGamesMay11 < ActiveRecord::Migration
  def up
    Game.transaction do
      end_stl_la_series!
      fix_tor_bos_times!
      fix_nyr_wsh_times!
      fix_pit_nyi_times!
    end
  end 

  def down
  end


  def end_stl_la_series!
    la = Team.find_by_code("LA")
    stl = Team.find_by_code("STL")

    # LA wins in 6
    games = Game.where(:home_id => la.id, :away_id => stl.id).where(
        ['faceoff_time > ?', Time.zone.parse('FRI MAY 10 2013 11:59PM ET')])    

    games.destroy_all

    games = Game.where(:home_id => stl.id, :away_id => la.id).where(
      ['faceoff_time > ?', Time.zone.parse('FRI MAY 10 2013 11:59PM ET')])          

    games.destroy_all
  end

  def fix_pit_nyi_times!
    pit = Team.find_by_code("PIT")
    nyi = Team.find_by_code("NYI")

    game = Game.where(:away_id => pit.id, :home_id => nyi.id, :faceoff_time => Time.zone.parse("SAT MAY 11 2013 12:00PM ET")).first
    game.faceoff_time = Time.zone.parse("SAT MAY 11 2013 7:00PM ET")
    game.save!

    game = Game.where(:away_id => nyi.id, :home_id => pit.id, :faceoff_time => Time.zone.parse("SUN MAY 12 2013 12:00PM ET")).first
    game.faceoff_time = Time.zone.parse("SUN MAY 12 2013 7:00PM ET")
    game.save!
  end

  def fix_tor_bos_times!
    tor = Team.find_by_code("TOR")
    bos = Team.find_by_code("BOS")

    game = Game.where(:away_id => bos.id, :home_id => tor.id, :faceoff_time => Time.zone.parse("SUN MAY 12, 2013 11:11AM ET")).first
    game.faceoff_time = Time.zone.parse("SUN MAY 12 2013 7:30PM ET")
    game.save!
  end

  def fix_nyr_wsh_times!
    nyr = Team.find_by_code("NYR")
    wsh = Team.find_by_code("WSH")

    game = Game.where(:away_id => wsh.id, :home_id => nyr.id, :faceoff_time => Time.zone.parse("SUN MAY 12, 2013 12:00 PM ET")).first
    game.faceoff_time = Time.zone.parse("SUN MAY 12, 2013 4:30 PM ET")
    game.save!
  end
end
