require 'open-uri'

class AuthController < ApplicationController
  def facebook
    user = User.find(params[:state])
    
    code = params[:code]
    client_id = '162741227192307'
    client_secret = '0f413e2e214bf855e6a350e9c4c76f97'
    redirect_uri = 'http://localhost:3000/auth/facebook'
    
    uri = "https://graph.facebook.com/oauth/access_token?client_id=#{client_id}&redirect_uri=#{redirect_uri}&client_secret=#{client_secret}&code=#{code}"
    
    response = open(uri).read
    access_token = response.split('&').first.split('=').last
    
    user.facebook_access_token = access_token
    
    me_response = JSON.parse(open("https://graph.facebook.com/me&access_token=#{access_token}").read)
    
    user.facebook_id = me_response["id"]
    user.name = me_response["name"]
    if me_response["location"].present?
      user.location = me_response["location"]["name"]
    end
    
    user.save
    
    redirect_to user
  end
end















