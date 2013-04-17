FactoryGirl.define do
  factory :game do
    faceoff_time Time.zone.parse("2013-04-16 19:00")
    home { FactoryGirl.build(:team) }
    away { FactoryGirl.build(:team) }
  end
end
