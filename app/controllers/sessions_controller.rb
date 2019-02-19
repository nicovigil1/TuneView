class SessionsController < ApplicationController
  def create
    user_info = spotify_params(request.env['omniauth.auth'].credentials, request.env['omniauth.auth'].info)

    user = User.find_by(username: user_info[:username]) || User.create(user_info)

    user.update(user_info)
    session[:user_id] = user.id
    flash[:success] = "Successfully signed in." if user.save

    redirect_to dashboard_path
  end

  def destroy
    session.clear
    flash[:notice] = "You are now logged out!"
    redirect_to '/'
  end

  private

  def spotify_params(credentials, profile)
    profile["image"] ||= "https://bit.ly/2tlLmZc"
    {
      username: profile["name"],
      image_url: profile["image"],
      spotify_token: credentials["token"],
      token_expire: 55.minutes.from_now,
      refresh_token: credentials["refresh_token"],
      profile_url: profile["urls"]["spotify"]
    }
  end
end
