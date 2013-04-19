FactoryGirl.define do
  factory :game do
    faceoff_time { 12.hours.from_now }
    home { FactoryGirl.build(:team) }
    away { FactoryGirl.build(:team) }

    factory :finished_game do
      finished true
      winner { self.home }
      home_score 5
      away_score 2
    end
  end

end
