class UsersController < ApplicationController

  def show
    recent_track = SpotifyService.most_recent_track(current_user)
    @title = recent_track.body[:items][0][:track][:name]
    @artist = recent_track.body[:items][0][:track][:artists][0][:name]
    @album = recent_track.body[:items].first[:track][:album][:name]
    @cover_url = recent_track.body[:items].first[:track][:album][:images][1][:url]
  end
end
