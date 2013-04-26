# encoding: UTF-8

require 'open-uri'
require 'rack'
require 'pry'
require 'rake'

namespace :puckpicks do
  task :scrape_scores => :environment do
    puts "Grabbing today's scores from ESPN..."

    results = ScoreScraper.new.get_todays_scores
    puts "Results:"
    puts results

    teams = Team.all

    results.each do |result|
      home_id = teams.select { |t| t.code == result[:home] }.first.id
      away_id = teams.select { |t| t.code == result[:away] }.first.id

      games = Game.since(24.hours.ago).where(:home_id => home_id, :away_id => away_id)

      if games.count != 1
        puts "Couldn't find a game matching #{result.away} vs #{result.home} in the past 24h."
        next
      end

      puts "Found a game matching #{result[:away]} vs #{result[:home]}."
      game = games.first

      if game.finished?
        puts "Game was already finished. Not doing anything."
        next
      else
        puts "setting home_score: #{result[:home_score]}, away_score: #{result[:away_score]}"
        game.set_result(:away_score => result[:away_score], :home_score => result[:home_score])
        game.save!
      end

    end


  end
end



class ScoreScraper

  # The ESPN bottomline URL returns a set of URI-encoded KVPs containing yesterday's scores.
      # e.g. &nhl_s_delay=120&nhl_s_stamp=0426081931&nhl_s_left1=NY%20Islanders%201%20%20%20^Philadelphia%202%20(FINAL)&nhl_s_right1_count=0&nhl_s_url1=http://sports.espn.go.com/nhl/boxscore?gameId=400443168&nhl_s_left2=^Ottawa%202%20%20%20Washington%201%20(FINAL%20-%20OT)&nhl_s_right2_count=0&nhl_s_url2=http://sports.espn.go.com/nhl/boxscore?gameId=400443169&nhl_s_left3=^NY%20Rangers%204%20%20%20Carolina%203%20(FINAL%20-%20OT)&nhl_s_right3_count=0&nhl_s_url3=http://sports.espn.go.com/nhl/boxscore?gameId=400443170&nhl_s_left4=Pittsburgh%202%20%20%20^New%20Jersey%203%20(FINAL)&nhl_s_right4_count=0&nhl_s_url4=http://sports.espn.go.com/nhl/boxscore?gameId=400443171&nhl_s_left5=^Toronto%204%20%20%20Florida%200%20(FINAL)&nhl_s_right5_count=0&nhl_s_url5=http://sports.espn.go.com/nhl/boxscore?gameId=400443172&nhl_s_left6=Nashville%202%20%20%20^Detroit%205%20(FINAL)&nhl_s_right6_count=0&nhl_s_url6=http://sports.espn.go.com/nhl/boxscore?gameId=400443173&nhl_s_left7=Tampa%20Bay%200%20%20%20^Boston%202%20(FINAL)&nhl_s_right7_count=0&nhl_s_url7=http://sports.espn.go.com/nhl/boxscore?gameId=400446257&nhl_s_left8=^Montreal%204%20%20%20Winnipeg%202%20(FINAL)&nhl_s_right8_count=0&nhl_s_url8=http://sports.espn.go.com/nhl/boxscore?gameId=400443174&nhl_s_left9=Calgary%201%20%20%20^St.%20Louis%204%20(FINAL)&nhl_s_right9_count=0&nhl_s_url9=http://sports.espn.go.com/nhl/boxscore?gameId=400443175&nhl_s_left10=^Columbus%203%20%20%20Dallas%201%20(FINAL)&nhl_s_right10_count=0&nhl_s_url10=http://sports.espn.go.com/nhl/boxscore?gameId=400443176&nhl_s_left11=^Anaheim%203%20%20%20Vancouver%201%20(FINAL)&nhl_s_right11_count=0&nhl_s_url11=http://sports.espn.go.com/nhl/boxscore?gameId=400443177&nhl_s_count=11&nhl_s_loaded=true
  URI = "http://sports.espn.go.com/nhl/bottomline/scores"

  CODES = {
    "CHICAGO" => "CHI",
    "COLUMBUS" => "CBJ",
    "DETROIT" => "DET",
    "NASHVILLE" => "NSH",
    "ST. LOUIS" => "STL",
    "NEW JERSEY" => "NJ",
    "NY ISLANDERS" => "NYI",
    "NY RANGERS" => "NYR",
    "PHILADELPHIA" => "PHI",
    "PITTSBURGH" => "PIT",
    "CALGARY" => "CGY",
    "COLORADO" => "COL",
    "EDMONTON" => "EDM",
    "MINNESOTA" => "MIN",
    "VANCOUVER" => "VAN",
    "BOSTON" => "BOS",
    "BUFFALO" => "BUF",
    "MONTRÉAL" => "MTL",
    "MONTREAL" => "MTL",
    "OTTAWA" => "OTT",
    "TORONTO" => "TOR",
    "ANAHEIM" => "ANA",
    "DALLAS" => "DAL",
    "LOS ANGELES" => "LA",
    "PHOENIX" => "PHX",
    "SAN JOSE" => "SJ",
    "CAROLINA" => "CAR",
    "FLORIDA" => "FLA",
    "TAMPA BAY" => "TB",
    "WASHINGTON" => "WSH",
    "WINNIPEG" => "WPG"
  }

  def get_todays_scores
    #data = open(URI).read

    # debug:
    data = '&nhl_s_delay=120&nhl_s_stamp=0426081931&nhl_s_left1=NY%20Islanders%201%20%20%20^Philadelphia%202%20(FINAL)&nhl_s_right1_count=0&nhl_s_url1=http://sports.espn.go.com/nhl/boxscore?gameId=400443168&nhl_s_left2=^Ottawa%202%20%20%20Washington%201%20(FINAL%20-%20OT)&nhl_s_right2_count=0&nhl_s_url2=http://sports.espn.go.com/nhl/boxscore?gameId=400443169&nhl_s_left3=^NY%20Rangers%204%20%20%20Carolina%203%20(FINAL%20-%20OT)&nhl_s_right3_count=0&nhl_s_url3=http://sports.espn.go.com/nhl/boxscore?gameId=400443170&nhl_s_left4=Pittsburgh%202%20%20%20^New%20Jersey%203%20(FINAL)&nhl_s_right4_count=0&nhl_s_url4=http://sports.espn.go.com/nhl/boxscore?gameId=400443171&nhl_s_left5=^Toronto%204%20%20%20Florida%200%20(FINAL)&nhl_s_right5_count=0&nhl_s_url5=http://sports.espn.go.com/nhl/boxscore?gameId=400443172&nhl_s_left6=Nashville%202%20%20%20^Detroit%205%20(FINAL)&nhl_s_right6_count=0&nhl_s_url6=http://sports.espn.go.com/nhl/boxscore?gameId=400443173&nhl_s_left7=Tampa%20Bay%200%20%20%20^Boston%202%20(FINAL)&nhl_s_right7_count=0&nhl_s_url7=http://sports.espn.go.com/nhl/boxscore?gameId=400446257&nhl_s_left8=^Montreal%204%20%20%20Winnipeg%202%20(FINAL)&nhl_s_right8_count=0&nhl_s_url8=http://sports.espn.go.com/nhl/boxscore?gameId=400443174&nhl_s_left9=Calgary%201%20%20%20^St.%20Louis%204%20(FINAL)&nhl_s_right9_count=0&nhl_s_url9=http://sports.espn.go.com/nhl/boxscore?gameId=400443175&nhl_s_left10=^Columbus%203%20%20%20Dallas%201%20(FINAL)&nhl_s_right10_count=0&nhl_s_url10=http://sports.espn.go.com/nhl/boxscore?gameId=400443176&nhl_s_left11=^Anaheim%203%20%20%20Vancouver%201%20(FINAL)&nhl_s_right11_count=0&nhl_s_url11=http://sports.espn.go.com/nhl/boxscore?gameId=400443177&nhl_s_count=11&nhl_s_loaded=true'

    parse(data)
  end

  def parse(text)

    # URI-decode the data.
    hash = Rack::Utils.parse_nested_query(text)

    # Now we have something like:
        # {"nhl_s_delay"=>"120",
        #   "nhl_s_stamp"=>"0426081507",
        #   "nhl_s_left1"=>"NY Islanders 1   ^Philadelphia 2 (FINAL)",
        #   "nhl_s_right1_count"=>"0",
        #   "nhl_s_url1"=>"http://sports.espn.go.com/nhl/boxscore?gameId=400443168",
        #   "nhl_s_left2"=>"^Ottawa 2   Washington 1 (FINAL - OT)",
        #   "nhl_s_right2_count"=>"0" 
        #    ....
        # }

    # Elements of the hash whose keys contain "left" (e.g. nhl_s_left4) point to the scores.    
    hash.select! { |k| k.include?("left") }



    # The values look like:
       # ^Montreal 4   Winnipeg 2 (FINAL)"
       # "^Anaheim 3   Vancouver 1 (FINAL)"
    # The carat (^) character indicates the winner.
    results = []

    re = /\^?(.+) (\d+)\s+\^?(.+) (\d+) \(FINAL/
    hash.values.each do |value|
      re.match(value)

      away = $1
      away_score = $2
      home = $3
      home_score = $4

      results.push({
        away: CODES[away.upcase],
        away_score: away_score.to_i,
        home: CODES[home.upcase],
        home_score: home_score.to_i 
      })
    end

    results
  end

end


