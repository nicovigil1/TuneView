class UsersController < ApplicationController
  before_action :require_login

  def show
    @user_info = SpotifyUserInfo.new(current_user)
    @top_5_artists = @user_info.top_5_artists
    @top_5_tracks = @user_info.top_5_tracks
    @most_recent_song = @user_info.most_recent_song
    @messages = Message.custom_display
    @message = Message.new
  end

  private

  def require_login
    unless current_user
      flash[:notice] = "You must be signed in to visit this page."
      redirect_to '/'
    end
  end
end
