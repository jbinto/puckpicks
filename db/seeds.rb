# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Team.destroy_all
Game.destroy_all

# Get around mass assignment for seeds.
Team.attr_accessible(:code, :city, :name, :logo)
Game.attr_accessible(:home, :away, :faceoff_time)

CHI = Team.create(code: 'CHI', city: 'Chicago', name: 'Blackhawks', logo: 'CHI.png')
CBJ = Team.create(code: 'CBJ', city: 'Columbus', name: 'Blue Jackets', logo: 'CBJ.png')
DET = Team.create(code: 'DET', city: 'Detroit', name: 'Red Wings', logo: 'DET.png')
NSH = Team.create(code: 'NSH', city: 'Nashville', name: 'Predators', logo: 'NSH.png')
STL = Team.create(code: 'STL', city: 'St. Louis', name: 'Blues', logo: 'STL.png')
NJ = Team.create(code: 'NJ', city: 'New Jersey', name: 'Devils', logo: 'NJ.png')
NYI = Team.create(code: 'NYI', city: 'New York', name: 'Islanders', logo: 'NYI.png')
NYR = Team.create(code: 'NYR', city: 'New York', name: 'Rangers', logo: 'NYR.png')
PHI = Team.create(code: 'PHI', city: 'Philadelphia', name: 'Flyers', logo: 'PHI.png')
PIT = Team.create(code: 'PIT', city: 'Pittsburgh', name: 'Penguins', logo: 'PIT.png')
CGY = Team.create(code: 'CGY', city: 'Calgary', name: 'Flames', logo: 'CGY.png')
COL = Team.create(code: 'COL', city: 'Colorado', name: 'Avalanche', logo: 'COL.png')
EDM = Team.create(code: 'EDM', city: 'Edmonton', name: 'Oilers', logo: 'EDM.png')
MIN = Team.create(code: 'MIN', city: 'Minnesota', name: 'Wild', logo: 'MIN.png')
VAN = Team.create(code: 'VAN', city: 'Vancouver', name: 'Canucks', logo: 'VAN.png')
BOS = Team.create(code: 'BOS', city: 'Boston', name: 'Bruins', logo: 'BOS.png')
BUF = Team.create(code: 'BUF', city: 'Buffalo', name: 'Sabres', logo: 'BUF.png')
MTL = Team.create(code: 'MTL', city: 'Montreal', name: 'Canadiens', logo: 'MTL.png')
OTT = Team.create(code: 'OTT', city: 'Ottawa', name: 'Senators', logo: 'OTT.png')
TOR = Team.create(code: 'TOR', city: 'Toronto', name: 'Maple Leafs', logo: 'TOR.png')
ANA = Team.create(code: 'ANA', city: 'Anaheim', name: 'Ducks', logo: 'ANA.png')
DAL = Team.create(code: 'DAL', city: 'Dallas', name: 'Stars', logo: 'DAL.png')
LA = Team.create(code: 'LA', city: 'Los Angeles', name: 'Kings', logo: 'LA.png')
PHX = Team.create(code: 'PHX', city: 'Phoenix', name: 'Coyotes', logo: 'PHX.png')
SJ = Team.create(code: 'SJ', city: 'San Jose', name: 'Sharks', logo: 'SJ.png')
CAR = Team.create(code: 'CAR', city: 'Carolina', name: 'Hurricanes', logo: 'CAR.png')
FLA = Team.create(code: 'FLA', city: 'Florida', name: 'Panthers', logo: 'FLA.png')
TB = Team.create(code: 'TB', city: 'Tampa Bay', name: 'Lightning', logo: 'TB.png')
WSH = Team.create(code: 'WSH', city: 'Washington', name: 'Capitals', logo: 'WSH.png')
WPG = Team.create(code: 'WPG', city: 'Winnipeg', name: 'Jets', logo: 'WPG.png')

Time.zone = "America/Toronto"

Game.create(away: FLA, home: NYI, faceoff_time: Time.zone.parse('2013-04-16 19:00'))
Game.create(away: TOR, home: WSH, faceoff_time: Time.zone.parse('2013-04-16 19:00'))
Game.create(away: CAR, home: OTT, faceoff_time: Time.zone.parse('2013-04-16 19:30'))
Game.create(away: NYR, home: PHI, faceoff_time: Time.zone.parse('2013-04-16 20:00'))
Game.create(away: TB,  home: WPG, faceoff_time: Time.zone.parse('2013-04-16 20:00'))
Game.create(away: VAN, home: STL, faceoff_time: Time.zone.parse('2013-04-16 21:30'))
Game.create(away: LA,  home: SJ,  faceoff_time: Time.zone.parse('2013-04-16 22:30'))


g = Game.last
g.update_attributes(winner: g.home, home_score: 5, away_score: 2)

binding.pry
