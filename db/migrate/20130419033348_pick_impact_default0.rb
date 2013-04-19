class PickImpactDefault0 < ActiveRecord::Migration
  def change
    Pick.all.each do |pick|
      pick.update_attribute(:impact, 0)
    end

    change_column :picks, :impact, :integer, :default => 0
  end
end
