  class Track
    attr_reader :title, :artist, :album, :cover_url 
    def initialize(data)
      @title = data[:name]
      @artist = data[:artists][0][:name]
      @album = data[:album][:name]
      @cover_url = data[:album][:images][1][:url]
    end 
  end
