class SpotifyService
  def self.conn(current_user)
    Faraday.new(url: "https://api.spotify.com") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.headers["Authorization"] = "Bearer #{current_user.spotify_token}" 
      faraday.response :json, :parser_options => { :symbolize_names => true }
    end
  end 

  def self.user_data(user)
    conn(user).get("/v1/me/").body
  end 

  def self.top_5_artists(user)
    params = "time_range=short_term&limit=5"
    response = conn(user).get("/v1/me/top/artists?#{params}").body
    response[:items]
  end 
end