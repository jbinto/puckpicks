class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.references :game
      t.references :team
      t.references :user
      t.integer :spread_wager
      t.integer :impact

      t.timestamps
    end
    add_index :picks, :game_id
    add_index :picks, :team_id
    add_index :picks, :user_id
  end
end
