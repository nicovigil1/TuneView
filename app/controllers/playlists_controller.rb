class PlaylistsController < ApplicationController
  def index
    @playlists = user_info.playlists
  end 

  def show
    @playlist = params[:playlist]
    @user_info = user_info
    @tracks = @user_info.get_playlist_tracks(params[:id])
    @metrics = @user_info.playlist_stats(params[:id])
  end 
end 