class Team < ActiveRecord::Base
  def full_name
    "#{city} #{name}"
  end
end
