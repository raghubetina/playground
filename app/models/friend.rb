class Friend < ActiveRecord::Base
  attr_accessible :facebook_id, :location, :name, :user_id
  
  belongs_to :user
  
  acts_as_gmappable

  def gmaps4rails_address
    self.location
  end
  
  def gmaps4rails_infowindow
    "<img src='https://graph.facebook.com/#{self.facebook_id}/picture'/> #{self.name}"
  end
end