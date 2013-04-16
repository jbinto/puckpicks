class SetNotNullable < ActiveRecord::Migration
  def up
    change_column :games, :faceoff_time, :datetime, :null => false
    change_column :games, :home_id, :integer, :null => false
    change_column :games, :away_id, :integer, :null => false
    change_column :games, :finished, :boolean, :null => false, :default => false

    change_column :users, :email, :string, :null => false
    change_column :users, :crypted_password, :string, :null => false
    change_column :users, :salt, :string, :null => false
  end

  def down
  end
end
