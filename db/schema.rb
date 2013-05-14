# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130514151720) do

  create_table "games", :force => true do |t|
    t.datetime "faceoff_time",                    :null => false
    t.integer  "home_id",                         :null => false
    t.integer  "away_id",                         :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.integer  "winner_id"
    t.integer  "home_score"
    t.integer  "away_score"
    t.boolean  "finished",     :default => false, :null => false
  end

  add_index "games", ["away_id"], :name => "index_games_on_away_id"
  add_index "games", ["home_id"], :name => "index_games_on_home_id"

  create_table "picks", :force => true do |t|
    t.integer  "game_id"
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "spread_wager"
    t.integer  "impact",       :default => 0
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "picks", ["game_id"], :name => "index_picks_on_game_id"
  add_index "picks", ["team_id"], :name => "index_picks_on_team_id"
  add_index "picks", ["user_id"], :name => "index_picks_on_user_id"

  create_table "teams", :force => true do |t|
    t.string   "code",       :null => false
    t.string   "city",       :null => false
    t.string   "name",       :null => false
    t.string   "logo",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                            :null => false
    t.string   "email",                               :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "salt",                                :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "admin",            :default => false
  end

end
