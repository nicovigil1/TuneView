class PlaylistsController < ApplicationController
  def index
    @playlists = SpotifyUserInfo.new(current_user).playlists
  end

  def show
    @user_info = SpotifyUserInfo.new(current_user)
    @playlist = params[:playlist].tr("-", " ")
    @tracks = @user_info.get_playlist_tracks(params[:id])
    @metrics = @user_info.playlist_stats(params[:id])
  end
end
