class Track
  attr_reader :title, :artist, :album, :cover_url, :id, :stats
  def initialize(data, stats = nil)
    @id = data[:id]
    @title = data[:name]
    @artist = data[:artists][0][:name]
    @album = data[:album][:name]
    @cover_url = data[:album][:images][1][:url]
    @stats = stats
  end

  def compress_title
    compressed_name = title.tr(" ", "-")
    compressed_name.tr(".", "")
  end
end
