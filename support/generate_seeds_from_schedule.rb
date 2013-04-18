# encoding: utf-8


# This file parses schedule.txt and outputs commands to be used in seeds.rb.

# I am doing the simplest thing that could possible work here. 
# No time to mess with Nokogiri for a one-time data import.

# Process:
# 1) Go to nhl.com/schedules. Copy/paste the table into schedule.txt.
# 2) If all is well you should get a file with 5 lines per game:
#     [date, away, home, time, network_or_score]
# 3) Translate each 5-line set into a single seeds.rb create command.

require 'pry'

team_codes = {
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

sched = File.read('schedule.txt').split("\n")
sched = sched.each_slice(5).to_a

sched.each do |game|
  date = game[0]
  home = game[1].strip
  away = game[2].strip
  time = game[3]
  network = game[4]

  puts "Game.create(away: #{team_codes[away]}, home: #{team_codes[home]}, faceoff_time: Time.zone.parse(\"#{date} #{time}\"))"
end



