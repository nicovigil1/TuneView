class ApplicationController < ActionController::Base
  before_action :expired_filter
  helper_method :current_user

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      redirect_to logout_path
    end
  end

  def expired_filter
    if current_user && SpotifyService.user_data(current_user)[:error]
      SpotifyService.refresh_token(current_user)
    else
      nil
    end
  end
end
