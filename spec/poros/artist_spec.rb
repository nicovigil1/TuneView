# frozen_string_literal: true

require 'rails_helper'

describe 'Artist' do
  context 'Attributes' do
    it 'can be created with a hash of data' do
      info = {
        name: 'Kendrick Lamar',
        images: %w[img1 img2],
        popularity: 90,
        genres: ['all the things'],
        followers: { total: 999 },
        href: 'google.com',
        id: '1234qwer'
      }

      artist = Artist.new(info)

      expect(artist.name).to eq('Kendrick Lamar')
      expect(artist.images).to eq(%w[img1 img2])
      expect(artist.popularity).to eq(90)
      expect(artist.genres).to eq(['all the things'])
      expect(artist.follow_count).to eq(999)
      expect(artist.href).to eq('google.com')
      expect(artist.uid).to eq('1234qwer')
    end
  end

  context 'generators' do
    it 'can generate top 5 artists for a user' do
      info = {
        username: '12184696969',
        image_url: 'https://bit.ly/2tlLmZc',
        spotify_token: ENV['S_TEST_TOKEN'],
        profile_url: 'https://open.spotify.com/user/12184696969'
      }

      current_user = User.create(info)
      VCR.use_cassette('artist-top-5') do
        result = Artist.top_5(current_user)

        expect(result.count).to eq(5)
        result.each do |artist|
          expect(artist.class).to eq(Artist)
        end
      end
    end
  end
end
