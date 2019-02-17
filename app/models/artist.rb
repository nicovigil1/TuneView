class Artist
  attr_reader :name, :images, :popularity, :genres, :follow_count, :href, :uid 

  def initialize(data)
    @name = data[:name]
    @images = data[:images]
    @popularity = data[:popularity]
    @genres = data[:genres]
    @follow_count = data[:followers][:total]
    @href = data[:href]
    @uid = data[:id]
  end 

end 