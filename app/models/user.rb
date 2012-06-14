class User < ActiveRecord::Base
  attr_accessible :email, :facebook_access_token, :facebook_id, :location, :name
  
  has_many :friends
  
  def get_friends
    self.friends.destroy_all
    
    friends_response = JSON.parse(open("https://graph.facebook.com/fql?q=#{CGI::escape("SELECT uid, name, current_location FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me())")}&access_token=#{self.facebook_access_token}").read)

    friends = friends_response["data"]
       
    friends.each do |friend_hash|
      if friend_hash["current_location"].present?
        self.friends.create facebook_id: friend_hash["uid"], name: friend_hash["name"], location: friend_hash["current_location"]["name"]
      end
    end
  end
end
