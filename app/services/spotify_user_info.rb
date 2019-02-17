class SpotifyUserInfo
  attr_reader :user, :top_5_artists, :most_recent_song, :playlists
  def initialize(user)
    @user = user
    @top_5_artists = UserFacade.top_5_artists(@user)
    @most_recent_song = UserFacade.most_recent_track(@user)
    @playlists = UserFacade.playlists(@user)
  end 
end 