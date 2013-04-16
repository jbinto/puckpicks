class AddResultsToGames < ActiveRecord::Migration
  def change
    change_column :teams, :code, :string, :null => false
    change_column :teams, :city, :string, :null => false
    change_column :teams, :name, :string, :null => false
    change_column :teams, :logo, :string, :null => false
    change_table :games do |t|
      t.references :winner
      t.integer :home_score
      t.integer :away_score
      t.boolean :finished
    end
  end
end
