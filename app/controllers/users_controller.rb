# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    # SpotifyService.refresh_token(current_user) #if token_expired?
    spotify_user_info = SpotifyUserInfo.new(current_user)
    @top_5_artists = spotify_user_info.top_5_artists
    @top_5_tracks
    @most_recent = spotify_user_info.most_recent_song
  end

  # private

  # def token_expired?
  #   # current_user.token_expiration > Time.now
  #   !nil
  # end
end
