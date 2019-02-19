class UsersController < ApplicationController
  before_action :require_login

  def show
    @facade = UserFacade.new(current_user)
    @top_5_artists = @facade.top_5_artists
    @top_5_tracks = @facade.top_5_tracks
    @most_recent_song = @facade.most_recent_track
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
