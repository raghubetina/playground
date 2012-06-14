class User < ActiveRecord::Base
  attr_accessible :email, :facebook_access_token, :facebook_id, :location, :name
  
  has_many :friends
end
