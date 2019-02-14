class UsersController < ApplicationController

  def show
    # SpotifyService.refresh_token(current_user) #if token_expired?
    s_service = SpotifyUserInfo.new(current_user)
    @top_5_artists = s_service.top_5_artists
    @top_5_tracks 
    @most_recent = s_service.most_recent_song
  end


  private
  # def token_expired?
  #   # current_user.token_expiration > Time.now
  #   !nil 
  # end 
end
