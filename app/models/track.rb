  class Track
    attr_reader :title, :artist, :album, :cover_url 
    def initialize(data)
      @title = data[:track][:name]
      @artist = data[:track][:artists][0][:name]
      @album = data[:track][:album][:name]
      @cover_url = data[:track][:album][:images][1][:url]
    end 
  end
