class EndVanSjSeries < ActiveRecord::Migration
  def up
    van = Team.find_by_code("VAN")
    sj = Team.find_by_code("SJ")
    
    Game.transaction do
      games = Game.where(:home_id => van.id, :away_id => sj.id).where(
        ['faceoff_time > ?', Time.zone.parse('TUE MAY 7 2013 11:59PM ET')])    

      games.destroy_all

      games = Game.where(:home_id => sj.id, :away_id => van.id).where(
        ['faceoff_time > ?', Time.zone.parse('TUE MAY 7 2013 11:59PM ET')])          

      games.destroy_all
    end
  end

  def down
  end
end
