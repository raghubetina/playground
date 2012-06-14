require 'open-uri'

class AuthController < ApplicationController
  def facebook
    code = params[:code]
    @user = User.find(params[:state])
    
    uri = "https://graph.facebook.com/oauth/access_token?client_id=162741227192307&redirect_uri=http://localhost:3000/auth/facebook&client_secret=0f413e2e214bf855e6a350e9c4c76f97&code=#{code}"
    
    access_token = open(uri).read.split('&').first.split('=').last
    
    @user.facebook_access_token = access_token
    @user.save
    
    redirect_to @user
  end
end
