class SpotifyService
  def self.conn
    Faraday.new(url: "https://api.spotify.com") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.headers["Authorization"] = "Bearer #{ENV['S_TEST_TOKEN']}" 
      faraday.response :json, :parser_options => { :symbolize_names => true }
    end
  end 

  def self.user_data(user)
    conn.get("/v1/me/").body
  end 
end