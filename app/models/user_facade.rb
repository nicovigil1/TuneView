class UserFacade
  attr_reader :user

  def initialize(user)
    @user = user
    @service = SpotifyService.new(@user)
  end

  def top_5_artists
    @top_5_artists ||= @service.top_5_artists.map do |data|
      Artist.new(data)
    end
  end

  def top_5_tracks
    @top_5_tracks ||= @service.top_5_tracks.map do |data|
      Track.new(data)
    end
  end

  def most_recent_track
    Track.new(@most_recent_track ||= @service.most_recent_track)
  end

  def playlists
    @playlist_data ||= @service.find_playlists.map do |data|
      Playlist.new(data)
    end
  end

  def playlist_stats(playlist_id)
    generate_playlist_stats(playlist_id)
    length = @hash[:length].to_f
    @hash.reduce({}) do |hash, (feature, metric)|
      hash[feature] = (metric / length).round(1)
      hash
    end
  end

  def generate_playlist_stats(playlist_id)
    playlists = @service.playlist_stats(playlist_id)
    @hash = Hash.new(0)
    length = playlists[:audio_features].length
    @hash[:length] = length
    results = playlists[:audio_features].flat_map do |metrics|
       metrics.map do |feature, metric|
        @hash[feature] += metric if (metric.class == Float || metric.class == Integer)
      end
    end
  end

  def get_playlist_tracks(playlist_id)
    @service.playlist_tracks(playlist_id).map do |track_data|
      Track.new(track_data[:track])
    end
  end
end
