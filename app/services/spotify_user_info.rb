class SpotifyUserInfo
  attr_reader :user, :top_5_artists
  def initialize(user)
    @user = user
    @top_5_artists = Artist.top_5(@user)
  end 
end 