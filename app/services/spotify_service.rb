class SpotifyService

  def self.top_5_artists(user)
    params = "time_range=short_term&limit=5"
    response = conn(user).get("/v1/me/top/artists?#{params}").body
    response[:items]
  end

  def self.top_5_tracks(user)
    params = "time_range=short_term&limit=5"
    response = conn(user).get("/v1/me/top/tracks?#{params}").body
    response[:items]
  end

  def self.most_recent_track(user)
    #FIXME
    user.reload
    con = conn(user)
    req = con.get("/v1/me/player/recently-played?type=track&limit=1")
    data = req.body
    # require 'pry'; binding.pry
    response = conn(user.reload).get("/v1/tracks/#{data[:items].first[:track][:id]}").body
    Track.new(response)
  end

  def self.find_playlists(user)
    data = conn(user).get do |c|
      c.url '/v1/me/playlists'
    end.body[:items]
  end

  def self.playlist_tracks(user, playlist_id)
    conn(user).get("/v1/playlists/#{playlist_id}/tracks").body[:items].map do |data|
      Track.new(data[:track])
    end
  end

  def self.playlist_stats(user, playlist_id)
    ids = conn(user).get("/v1/playlists/#{playlist_id}/tracks").body[:items].map do |data|
      data[:track][:id]
    end
    conn(user).get("/v1/audio-features/?ids=#{ids.join(",")}").body
  end

  private

  def self.refresh_token(user)
    response = Faraday.post("https://accounts.spotify.com/api/token") do |req|
      req.headers["Content-Type"] = "application/x-www-form-urlencoded"
      req.headers["Authorization"] = "Basic #{encoded_key_id}"
      req.body = {"grant_type":"refresh_token", "refresh_token":"#{user.refresh_token}"}
    end
    user.update(spotify_token: JSON.parse(response.body)["access_token"])
    JSON.parse(response.body)["access_token"]
  end

  def self.conn(current_user)
    Faraday.new(url: "https://api.spotify.com") do |faraday|
      faraday.request :url_encoded
      faraday.headers["Authorization"] = "Bearer #{current_user.spotify_token}"
      faraday.response :json, :parser_options => { :symbolize_names => true }
      faraday.adapter Faraday.default_adapter
    end
  end

  def self.encoded_key_id
    Base64.strict_encode64("#{ENV["SPOTIFY_CLIENT_ID"]}:#{ENV["SPOTIFY_CLIENT_SECRET"]}")
  end

  def self.user_data(user)
    conn(user).get("/v1/me/").body
  end

end
