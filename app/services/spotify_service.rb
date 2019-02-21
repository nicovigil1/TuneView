class SpotifyService
  attr_reader :user

  def initialize(user)
    @user = user
    @@api_cache ||= TimeHash.new
  end

  def top_5_artists
    through_cache(:top_5_artists) do
      top_5("artists")
    end
  end

  def top_5_tracks
    through_cache(:top_5_tracks) do
      top_5("tracks")
    end
  end

  def find_playlists
    through_cache(:playlists) do
      conn.get('/v1/me/playlists').body[:items]
    end
  end

  def playlist_tracks(playlist_id)
    through_cache("playlist-tracks-#{playlist_id}") do
      conn.get("/v1/playlists/#{playlist_id}/tracks").body[:items]
    end
  end

  def playlist_stats(playlist_id)
    through_cache("playlist-stats-#{playlist_id}") do
      ids = conn.get("/v1/playlists/#{playlist_id}/tracks").body[:items].map do |data|
        data[:track][:id]
      end

      conn.get("/v1/audio-features/?ids=#{ids.join(",")}").body
    end
  end

  def most_recent_track
    through_cache(:most_recent_track) do
      data = conn.get("/v1/me/player/recently-played?type=track&limit=1").body
      conn.get(data[:items].first[:track][:href]).body
    end
  end

  def user_data
    through_cache(:user_data) do
      conn.get("/v1/me/").body
    end
  end

  def get_track(id, stats = false)
    if stats
      through_cache("track-stats-#{id}") do
        Track.new(track_info(id), track_stats(conn.get("/v1/audio-features/#{id}").body))
      end
    else
      through_cache("track-#{id}") do
        Track.new(track_info(id))
      end
    end
  end

  def refresh_token
    response = Faraday.post("https://accounts.spotify.com/api/token") do |req|
      req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      req.headers["Authorization"] = "Basic #{SpotifyService.encoded_key_id}"
      req.body = {"grant_type":"refresh_token", "refresh_token":"#{@user.refresh_token}"}
    end

    user.update(spotify_token: JSON.parse(response.body)["access_token"], token_expire: 55.minutes.from_now)
    JSON.parse(response.body)["access_token"]
  end

  private

  def track_stats(raw)
    keys = [:type, :id, :uri, :track_href, :analysis_url, :duration_ms, :mode]
    keys.each { |k| raw.delete(k) }
    raw
  end

  def track_info(id)
    through_cache("track-info-#{id}") do
      conn.get("/v1/tracks/#{id}").body
    end
  end

  def conn
    @conn ||= Faraday.new(url: "https://api.spotify.com") do |faraday|
      faraday.request :url_encoded
      faraday.headers["Authorization"] = "Bearer #{@user.spotify_token}"
      faraday.response :json, :parser_options => { :symbolize_names => true }
      faraday.adapter Faraday.default_adapter
    end
  end

  def top_5(type)
    conn.get("/v1/me/top/#{type}?time_range=short_term&limit=5").body[:items]
  end

  def through_cache(key, &block)
    @@api_cache[key] || @@api_cache.put("#{@user.username}-key", block.call, ENV["SPOTIFY_API_CACHE_TIME"].to_i)
  end

  def self.encoded_key_id
    Base64.strict_encode64("#{ENV["SPOTIFY_CLIENT_ID"]}:#{ENV["SPOTIFY_CLIENT_SECRET"]}")
  end
end
