  class Track
    attr_reader :title, :artist, :album, :cover_url 
    def initialize(data)
      @title = data[:items][0][:track][:name]
      @artist = data[:items][0][:track][:artists][0][:name]
      @album = data[:items].first[:track][:album][:name]
      @cover_url = data[:items].first[:track][:album][:images][1][:url]
    end 
  end
