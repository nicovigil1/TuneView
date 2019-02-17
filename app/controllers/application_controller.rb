class ApplicationController < ActionController::Base
  before_action :expired_filter
  helper_method :current_user, :playlists

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def expired_filter
    if current_user && SpotifyService.user_data(current_user)[:error]
      SpotifyService.refresh_token(current_user)
    else 
      nil
    end 
  end 
  
  def user_info    
    user_info = SpotifyUserInfo.new(current_user)
    user_info
  end 
end
