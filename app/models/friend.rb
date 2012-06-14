class Friend < ActiveRecord::Base
  attr_accessible :facebook_id, :location, :name, :user_id
  
  belongs_to :user
end
