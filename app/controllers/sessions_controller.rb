class SessionsController < ApplicationController
  def create
    user_info = spotify_params(request.env['omniauth.auth'].credentials, 
                        request.env['omniauth.auth'].info)
    user = User.create(user_info)
    session[:user_id] = user.id
    redirect_to home_path
  end

  private 

  def spotify_params(credentials, profile)
    profile["image"] ||= "https://bit.ly/2tlLmZc"
    {username: profile["nickname"],
     image_url: profile["image"], 
     spotify_token: credentials["token"],
     profile_url: profile["urls"]["spotify"]}
  end

end 