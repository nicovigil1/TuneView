class UserFacade
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def top_5_artists
    @top_5_artists ||= SpotifyService.top_5_artists(user).map do |data|
      Artist.new(data)
    end
  end

  def top_5_tracks
    @top_5_tracks ||= SpotifyService.top_5_tracks(user).map do |data|
      Track.new(data)
    end
  end

  def most_recent_track
    @most_recent_track ||= SpotifyService.most_recent_track(user)
  end

  def playlists
    @playlist_data ||= SpotifyService.find_playlists(user).map do |data|
      Playlist.new(data)
    end
  end

  def self.for_user(user)
    @@cache ||= TimeHash.new

    if @@cache.has_key?(user.id)
      @@cache[user.id]
    else
      @@cache.put(user.id, new(user), (ENV["SPOTIFY_API_CACHE_TIME"] || 60))
    end
  end
end
