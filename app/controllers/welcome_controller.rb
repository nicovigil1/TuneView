class WelcomeController < ApplicationController
  def index
    @top_5_artists = SpotifyUserInfo
  end
end
