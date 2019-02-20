class SessionsController < ApplicationController
  def create
    user_exists_login if (@user = User.find_by(username: user_info[:username]))

    @user = User.new(user_info)

    successful_login if @user.save
  end

  def destroy
    session.clear
    flash[:notice] = "You are now logged out!"
    redirect_to '/'
  end

  private

  def successful_login
    flash[:success] = "Successfully signed in."
    session[:user_id] = @user.id

    redirect_to dashboard_path
  end

  def user_exists_login
    @user.update(user_info)
    successful_login
  end

  def user_info
    spotify_params(request.env['omniauth.auth'].credentials, request.env['omniauth.auth'].info)
  end

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
