class EndChiMinOttMtlSeries < ActiveRecord::Migration
  def up
    mtl = Team.find_by_code("MTL")
    ott = Team.find_by_code("OTT")
    
    Game.transaction do
      games = Game.where(:home_id => mtl.id, :away_id => ott.id).where(
        ['faceoff_time > ?', Time.zone.parse('THU MAY 9 2013 11:59PM ET')])    

      games.destroy_all

      games = Game.where(:home_id => ott.id, :away_id => mtl.id).where(
        ['faceoff_time > ?', Time.zone.parse('THU MAY 9 2013 11:59PM ET')])          

      games.destroy_all
    end

    chi = Team.find_by_code("CHI")
    min = Team.find_by_code("MIN")
    
    Game.transaction do
      games = Game.where(:home_id => chi.id, :away_id => min.id).where(
        ['faceoff_time > ?', Time.zone.parse('THU MAY 9 2013 11:59PM ET')])    

      games.destroy_all

      games = Game.where(:home_id => min.id, :away_id => chi.id).where(
        ['faceoff_time > ?', Time.zone.parse('THU MAY 9 2013 11:59PM ET')])          

      games.destroy_all
    end
  end

  def down
  end
end

