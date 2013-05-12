class FixGamesMay12 < ActiveRecord::Migration
  def up
    Game.transaction do 
      end_pit_ny_series!
      fix_det_ana_times!
    end
  end

  def down
  end

  def end_pit_ny_series!
    pit = Team.find_by_code("PIT")
    nyi = Team.find_by_code("NYI")

    # PIT wins in 6
    games = Game.where(:home_id => pit.id, :away_id => nyi.id).where(
        ['faceoff_time > ?', Time.zone.parse('SAT MAY 11 2013 11:59PM ET')])    

    games.destroy_all

    games = Game.where(:home_id => nyi.id, :away_id => pit.id).where(
      ['faceoff_time > ?', Time.zone.parse('SAT MAY 11 2013 11:59PM ET')])          

    games.destroy_all
  end

  def fix_det_ana_times!
    det = Team.find_by_code("DET")
    ana = Team.find_by_code("ANA")

    game = Game.where(:away_id => det.id, :home_id => ana.id, :faceoff_time => Time.zone.parse("SUN MAY 12, 2013 11:11AM ET")).first
    game.faceoff_time = Time.zone.parse("SUN MAY 12 2013 10:00PM ET")
    game.save!
  end
end
