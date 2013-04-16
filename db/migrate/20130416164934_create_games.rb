class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :faceoff_time
      t.references :home
      t.references :away

      t.timestamps
    end
    add_index :games, :home_id
    add_index :games, :away_id
  end
end
