class TracksController < ApplicationController
  before_action :require_login

  def show
    service = SpotifyService.new(current_user)
    @track = service.get_track(params[:id], true)
  end
end
