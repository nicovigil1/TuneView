class SessionsController < ApplicationController
  def create
    user_info = spotify_params(request.env['omniauth.auth'].credentials,
                        request.env['omniauth.auth'].info)
    user = User.create(user_info)
    require 'pry'; binding.pry
    session[:user_id] = user.id
    flash[:success] = "Successfully signed in."
    redirect_to dashboard_path
  end

  private

  def spotify_params(credentials, profile)
    profile["image"] ||= "https://bit.ly/2tlLmZc"
    {username: profile["nickname"],
     image_url: profile["image"],
     spotify_token: credentials["token"],
     refresh_token: credentials["refresh_token"]
     profile_url: profile["urls"]["spotify"]}
  end

end
