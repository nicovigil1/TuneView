class ApplicationController < ActionController::Base
  before_action :expired_filter
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def expired_filter
    SpotifyService.new(current_user).refresh_token if current_user && current_user.token_expired?
  end
end
