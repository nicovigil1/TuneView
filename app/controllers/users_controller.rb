class UsersController < ApplicationController

  def show
    @user_info = user_info
    @top_5_artists = user_info.top_5_artists
    @top_5_tracks = user_info.top_5_tracks
    @most_recent_song = user_info.most_recent_song
    @messages = Message.custom_display
    @message = Message.new
  end
  # private
  # def token_expired?
  #   # current_user.token_expiration > Time.now
  #   !nil
  # end
end
