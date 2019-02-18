class UsersController < ApplicationController

  def show
    # SpotifyService.refresh_token(current_user)  #if token_expired?
    @user_info = user_info
    @top_5_artists = @user_info.top_5_artists
    @top_5_tracks = @user_info.top_5_tracks
    @most_recent = @user_info.most_recent_song
  end


  private
  # def token_expired?
  #   # current_user.token_expiration > Time.now
  #   !nil
  # end
end
