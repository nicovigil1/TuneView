class SpotifyUserInfo
  attr_reader :user, :top_5_artists, :top_5_tracks, :most_recent_song, :playlists, :hash
  def initialize(user)
    @user = user
    @top_5_artists = UserFacade.top_5_artists(@user)
    @top_5_tracks = UserFacade.top_5_tracks(@user)
    @most_recent_song = UserFacade.most_recent_track(@user)
    @playlists = UserFacade.playlists(@user)
    @hash = nil
  end 

  def get_playlist_tracks(playlist_id)
    SpotifyService.playlist_tracks(@user, playlist_id)
  end
  
  def generate_playlist_stats(playlist_id)
    playlists = SpotifyService.playlist_stats(@user, playlist_id)
    @hash = Hash.new(0)
    length = playlists[:audio_features].length
    @hash[:length] = length
    results = playlists[:audio_features].flat_map do |metrics|
       metrics.map do |feature, metric|
        @hash[feature] += metric if (metric.class == Float || metric.class == Integer)
      end
    end
  end

  def playlist_stats(playlist_id)
    generate_playlist_stats(playlist_id)
    length = @hash[:length].to_f
    stats = {}
    @hash.map do |feature, metric|
      stats[feature] = (metric / length).round(1)
    end
    stats
  end 
end 