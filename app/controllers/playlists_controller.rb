class PlaylistsController < ApplicationController
  before_action :require_login
  
  def index
    @playlists = UserFacade.new(current_user).playlists
  end

  def show
    @facade = UserFacade.new(current_user)
    @playlist = params[:playlist].tr("-", " ")
    @tracks = @facade.get_playlist_tracks(params[:id])
    @metrics = @facade.playlist_stats(params[:id])
  end
end
