class ApplicationController < ActionController::Base
  before_action :expired_filter
  helper_method :current_user

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  def expired_filter
    if SpotifyService.user_data(current_user)[:error]
      SpotifyService.refresh_token(current_user)
    else 
      nil
    end 
  end 
end
