class AddFirstRoundGames < ActiveRecord::Migration
  def up
    Game.attr_accessible(:home, :away, :faceoff_time)

    # 1 PIT vs 8 NYI
    Game.create(home: t('PIT'), away: t('NYI'), faceoff_time: Time.zone.parse("WED MAY 1, 2013 7:30 PM ET"))
    Game.create(home: t('PIT'), away: t('NYI'), faceoff_time: Time.zone.parse("FRI MAY 3, 2013 7:00 PM ET"))    
    Game.create(home: t('NYI'), away: t('PIT'), faceoff_time: Time.zone.parse("SUN MAY 5, 2013 12:00 PM ET"))
    Game.create(home: t('NYI'), away: t('PIT'), faceoff_time: Time.zone.parse("TUE MAY 7, 2013 7:00 PM ET"))
    Game.create(home: t('PIT'), away: t('NYI'), faceoff_time: Time.zone.parse("THU MAY 9, 2013 7:00 PM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('NYI'), away: t('PIT'), faceoff_time: Time.zone.parse("SAT MAY 11, 2013 12:00 PM ET"))
    Game.create(home: t('PIT'), away: t('NYI'), faceoff_time: Time.zone.parse("SUN MAY 12, 2013 12:00 PM ET"))


    # 2 MTL vs 7 OTT
    Game.create(home: t('MTL'), away: t('OTT'), faceoff_time: Time.zone.parse("THU MAY 2, 2013 7:00 PM ET"))
    Game.create(home: t('MTL'), away: t('OTT'), faceoff_time: Time.zone.parse("FRI MAY 3, 2013 7:00 PM ET"))    
    Game.create(home: t('OTT'), away: t('MTL'), faceoff_time: Time.zone.parse("SUN MAY 5, 2013 7:00 PM ET"))
    Game.create(home: t('OTT'), away: t('MTL'), faceoff_time: Time.zone.parse("TUE MAY 7, 2013 7:00 PM ET"))
    Game.create(home: t('MTL'), away: t('OTT'), faceoff_time: Time.zone.parse("THU MAY 9, 2013 7:00 PM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('OTT'), away: t('MTL'), faceoff_time: Time.zone.parse("SAT MAY 11, 2013 12:00 PM ET"))
    Game.create(home: t('MTL'), away: t('OTT'), faceoff_time: Time.zone.parse("SUN MAY 12, 2013 12:00 PM ET"))


    # 3 WSH vs 6 NYR
    Game.create(home: t('WSH'), away: t('NYR'), faceoff_time: Time.zone.parse("THU MAY 2, 2013 7:30 PM ET"))
    Game.create(home: t('WSH'), away: t('NYR'), faceoff_time: Time.zone.parse("SAT MAY 4, 2013 12:30 PM ET"))    
    Game.create(home: t('NYR'), away: t('WSH'), faceoff_time: Time.zone.parse("MON MAY 6, 2013 7:30 PM ET"))
    Game.create(home: t('NYR'), away: t('WSH'), faceoff_time: Time.zone.parse("WED MAY 8, 2012 7:30 PM ET"))
    Game.create(home: t('WSH'), away: t('NYR'), faceoff_time: Time.zone.parse("FRI MAY 10, 2013 7:30 PM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('NYR'), away: t('WSH'), faceoff_time: Time.zone.parse("SUN MAY 12, 2013 12:00 PM ET"))
    Game.create(home: t('WSH'), away: t('NYR'), faceoff_time: Time.zone.parse("MON MAY 13, 2013 12:00 PM ET"))

    
    # 4 BOS vs 5 TOR
    Game.create(home: t('BOS'), away: t('TOR'), faceoff_time: Time.zone.parse("WED MAY 1, 2013 7:00PM ET"))
    Game.create(home: t('BOS'), away: t('TOR'), faceoff_time: Time.zone.parse("SAT MAY 4, 2013 7:00PM ET"))    
    Game.create(home: t('TOR'), away: t('BOS'), faceoff_time: Time.zone.parse("MON MAY 6, 2013 7:00PM ET"))
    Game.create(home: t('TOR'), away: t('BOS'), faceoff_time: Time.zone.parse("WED MAY 8, 2013 7:00PM ET"))
    Game.create(home: t('BOS'), away: t('TOR'), faceoff_time: Time.zone.parse("FRI MAY 10, 2013 7:00PM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('TOR'), away: t('BOS'), faceoff_time: Time.zone.parse("SUN MAY 12, 2013 11:11AM ET"))
    Game.create(home: t('BOS'), away: t('TOR'), faceoff_time: Time.zone.parse("MON MAY 13, 2013 11:11AM ET"))


    # 1 CHI vs 8 MIN
    Game.create(home: t('CHI'), away: t('MIN'), faceoff_time: Time.zone.parse("TUE APR 30, 2013 8:00PM ET"))
    Game.create(home: t('CHI'), away: t('MIN'), faceoff_time: Time.zone.parse("THU MAY 2, 2013 9:30PM ET"))    
    Game.create(home: t('MIN'), away: t('CHI'), faceoff_time: Time.zone.parse("SAT MAY 4, 2013 3:00PM ET"))
    Game.create(home: t('MIN'), away: t('CHI'), faceoff_time: Time.zone.parse("MON MAY 6, 2013 9:30PM ET"))
    Game.create(home: t('CHI'), away: t('MIN'), faceoff_time: Time.zone.parse("WED MAY 8, 2013 11:11AM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('MIN'), away: t('CHI'), faceoff_time: Time.zone.parse("FRI MAY 10, 2013 11:11AM ET"))
    Game.create(home: t('CHI'), away: t('MIN'), faceoff_time: Time.zone.parse("SUN MAY 12, 2013 11:11AM ET"))

    # 2 ANA vs 7 DET
    Game.create(home: t('ANA'), away: t('DET'), faceoff_time: Time.zone.parse("TUE APR 30, 2013 10:30PM ET"))
    Game.create(home: t('ANA'), away: t('DET'), faceoff_time: Time.zone.parse("THU MAY 2, 2013 10:00PM ET"))    
    Game.create(home: t('DET'), away: t('ANA'), faceoff_time: Time.zone.parse("SAT MAY 4, 2013 7:30PM ET"))
    Game.create(home: t('DET'), away: t('ANA'), faceoff_time: Time.zone.parse("MON MAY 6, 2013 8:00PM ET"))
    Game.create(home: t('ANA'), away: t('DET'), faceoff_time: Time.zone.parse("WED MAY 8, 2013 10:00PM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('DET'), away: t('ANA'), faceoff_time: Time.zone.parse("FRI MAY 10, 2013 11:11AM ET"))
    Game.create(home: t('ANA'), away: t('DET'), faceoff_time: Time.zone.parse("SUN MAY 12, 2013 11:11AM ET"))

    # 3 VAN vs 6 SJ
    Game.create(home: t('VAN'), away: t('SJ'), faceoff_time: Time.zone.parse("WED MAY 1, 2013 10:30PM ET"))
    Game.create(home: t('VAN'), away: t('SJ'), faceoff_time: Time.zone.parse("FRI MAY 3, 2013 10:00PM ET"))    
    Game.create(home: t('SJ'), away: t('VAN'), faceoff_time: Time.zone.parse("SUN MAY 5, 2013 10:00PM ET"))
    Game.create(home: t('SJ'), away: t('VAN'), faceoff_time: Time.zone.parse("TUE MAY 7, 2013 10:00PM ET"))
    Game.create(home: t('VAN'), away: t('SJ'), faceoff_time: Time.zone.parse("THU MAY 9, 2013 10:00PM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('SJ'), away: t('VAN'), faceoff_time: Time.zone.parse("SAT MAY 11, 2013 11:11AM ET"))
    Game.create(home: t('VAN'), away: t('SJ'), faceoff_time: Time.zone.parse("MON MAY 13, 2013 11:11AM ET"))


    # 4 STL vs 5 LA
    Game.create(home: t('STL'), away: t('LA'), faceoff_time: Time.zone.parse("TUE APR 30, 2013 8:00PM ET"))
    Game.create(home: t('STL'), away: t('LA'), faceoff_time: Time.zone.parse("THU MAY 2, 2013 9:30PM ET"))    
    Game.create(home: t('LA'), away: t('STL'), faceoff_time: Time.zone.parse("SAT MAY 4, 2013 10:00PM ET"))
    Game.create(home: t('LA'), away: t('STL'), faceoff_time: Time.zone.parse("MON MAY 6, 2013 10:00PM ET"))
    Game.create(home: t('STL'), away: t('LA'), faceoff_time: Time.zone.parse("WED MAY 8, 2013 11:11AM ET"))
    # Games 6 & 7 time TBD!!
    Game.create(home: t('LA'), away: t('STL'), faceoff_time: Time.zone.parse("FRI MAY 10, 2013 11:11AM ET"))
    Game.create(home: t('STL'), away: t('LA'), faceoff_time: Time.zone.parse("MON MAY 13, 2013 11:11AM ET"))


  end

  def down
  end

  def t(code)
    Team.where(:code => code).first
  end
end
