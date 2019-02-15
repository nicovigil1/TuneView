# frozen_string_literal: true

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

  def self.top_5(user)
    artist_data = SpotifyService.top_5_artists(user)
    artist_data.map do |data|
      Artist.new(data)
    end
  end
end
