class Playlist
  attr_reader :name, :collaborative, :images, :public,
              :tracks, :track_count, :type, :id
  
  def initialize(info)
    @id = info[:id]
    @name = info[:name]
    @collaborative = info[:collaborative]
    @images = info[:images]
    @public = info[:public]
    @tracks = info[:tracks][:href]
    @track_count = info[:tracks][:total]
    @type = info[:type]
  end
end 