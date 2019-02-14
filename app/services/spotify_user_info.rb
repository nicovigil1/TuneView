class SpotifyUserInfo
  attr_reader :user, :top_5_artists, :most_recent_song
  def initialize(user)
    @user = user
    @top_5_artists = Artist.top_5(user)
    @most_recent_song = SpotifyService.most_recent_track(user)
  end 
end 