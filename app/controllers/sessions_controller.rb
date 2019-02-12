class SessionsController < ApplicationController
  def create
    spotify_credentials = request.env['omniauth.auth'].credentials
    spotify_profile = request.env['omniauth.auth'].info
    info = {username: spotify_profile["nickname"], image_url: spotify_profile["image"], spotify_token: spotify_credentials["token"], profile_url: spotify_profile["urls"]["spotify"] }
    User.create(info)
  end
end 