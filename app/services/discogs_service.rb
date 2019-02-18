class DiscogsService
  def self.conn
    Faraday.new(url: "https://api.discogs.com") do |conn|
      conn.request :url_encoded
      conn.params["key"] = ENV["DISCOGS_KEY"]
      conn.params["secret"] = ENV["DISCOGS_SECRET"]
      conn.response :json, :parser_options => {symbolize_names: true}
      conn.adapter Faraday.default_adapter
    end
  end

  def self.search(query, type)
    params = "{#{query}}&{?#{type}}&{release}&{?type}"
    conn.get("database/search?q=#{params}")
  end
end
