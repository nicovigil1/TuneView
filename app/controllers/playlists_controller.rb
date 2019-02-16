class PlaylistsController < ApplicationController
  def index
    user_info = SpotifyUserInfo.new(current_user)
    @playlists = user_info.playlists
  end 
end 