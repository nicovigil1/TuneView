class SpotifyService
  attr_reader :user
  
  def initialize(user)
    @user = user
    @api_cache = TimeHash.new
  end

  def top_5_artists
    through_cache(:top_5_artists, top_5("artists"))
  end

  def top_5_tracks
    through_cache(:top_5_tracks, top_5("tracks"))
  end

  def find_playlists
    through_cache(:playlists, conn.get('/v1/me/playlists').body[:items])
  end

  def playlist_tracks(playlist_id)
    through_cache(:playlist_tracks, conn.get("/v1/playlists/#{playlist_id}/tracks").body[:items])
  end

  def playlist_stats(playlist_id)
    ids = conn.get("/v1/playlists/#{playlist_id}/tracks").body[:items].map do |data|
      data[:track][:id]
    end
    conn.get("/v1/audio-features/?ids=#{ids.join(",")}").body
  end

  def most_recent_track
    # FIXME:
    data = conn.get("/v1/me/player/recently-played?type=track&limit=1").body
    conn.get(data[:items].first[:track][:href]).body
  end

  def user_data
    conn.get("/v1/me/").body
  end

  private

  def conn
    @conn ||= Faraday.new(url: "https://api.spotify.com") do |faraday|
      faraday.request :url_encoded
      faraday.headers["Authorization"] = "Bearer #{@user.spotify_token}"
      faraday.response :json, :parser_options => { :symbolize_names => true }
      faraday.adapter Faraday.default_adapter
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

  def top_5(type)
    conn.get("/v1/me/top/#{type}?time_range=short_term&limit=5").body[:items]
  end

  def through_cache(key, value)
    @api_cache[key] || @api_cache.put(key, value, ENV["SPOTIFY_API_CACHE_TIME"].to_i)
  end

  def self.encoded_key_id
    Base64.strict_encode64("#{ENV["SPOTIFY_CLIENT_ID"]}:#{ENV["SPOTIFY_CLIENT_SECRET"]}")
  end
end
