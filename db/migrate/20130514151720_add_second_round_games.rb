class AddSecondRoundGames < ActiveRecord::Migration
  def up
    Game.attr_accessible(:home, :away, :faceoff_time)

    # 1 PIT vs 7 OTT
    Game.create(home: t('PIT'), away: t('OTT'), faceoff_time: Time.zone.parse("TUE MAY 14, 2013 7:30 PM ET"))
    Game.create(home: t('PIT'), away: t('OTT'), faceoff_time: Time.zone.parse("FRI MAY 17, 2013 7:00 PM ET"))    
    Game.create(home: t('OTT'), away: t('PIT'), faceoff_time: Time.zone.parse("SUN MAY 19, 2013 7:30 PM ET"))
    Game.create(home: t('OTT'), away: t('PIT'), faceoff_time: Time.zone.parse("WED MAY 22, 2013 7:30 PM ET"))
    Game.create(home: t('PIT'), away: t('OTT'), faceoff_time: Time.zone.parse("FRI MAY 24, 2013 7:30 PM ET"))
    # Games 6 & 7 time TBD!!

    # 4 BOS vs 6 NYR
    Game.create(home: t('BOS'), away: t('NYR'), faceoff_time: Time.zone.parse("THU MAY 16, 2013 7:30 PM ET"))
    Game.create(home: t('BOS'), away: t('NYR'), faceoff_time: Time.zone.parse("SUN MAY 19, 2013 3:00 PM ET"))    
    Game.create(home: t('NYR'), away: t('BOS'), faceoff_time: Time.zone.parse("TUE MAY 21, 2013 7:30 PM ET"))
    Game.create(home: t('NYR'), away: t('BOS'), faceoff_time: Time.zone.parse("THU MAY 23, 2013 7:00 PM ET"))
    # Games 5, 6 & 7 time TBD!!

    # 1 CHI vs 7 DET
    Game.create(home: t('CHI'), away: t('DET'), faceoff_time: Time.zone.parse("WED MAY 15, 2013 8:00 PM ET"))
    Game.create(home: t('CHI'), away: t('DET'), faceoff_time: Time.zone.parse("SAT MAY 18, 2013 1:00 PM ET"))    
    Game.create(home: t('DET'), away: t('CHI'), faceoff_time: Time.zone.parse("MON MAY 20, 2013 7:30 PM ET"))
    Game.create(home: t('DET'), away: t('CHI'), faceoff_time: Time.zone.parse("THU MAY 23, 2013 8:00 PM ET"))
    # Games 5, 6 & 7 time TBD!!

    # 5 LA vs 6 SJ
    Game.create(home: t('LA'), away: t('SJ'), faceoff_time: Time.zone.parse("TUE MAY 14, 2013 10:00 PM ET"))
    Game.create(home: t('LA'), away: t('SJ'), faceoff_time: Time.zone.parse("THU MAY 16, 2013 10:00 PM ET"))    
    Game.create(home: t('SJ'), away: t('LA'), faceoff_time: Time.zone.parse("SAT MAY 18, 2013 9:00 PM ET"))
    Game.create(home: t('SJ'), away: t('LA'), faceoff_time: Time.zone.parse("TUE MAY 21, 2013 10:00 PM ET"))
    Game.create(home: t('LA'), away: t('SJ'), faceoff_time: Time.zone.parse("THU MAY 23, 2013 10:30 PM ET"))
    # Games 6 & 7 time TBD!!

  end

  def down
  end

  def t(code)
    Team.where(:code => code).first
  end
end
