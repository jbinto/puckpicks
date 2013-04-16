class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :name

  validates :email, :presence => true, :uniqueness => true  
  validates :password, :presence => true, :on => :create
  validates_confirmation_of :password
end
