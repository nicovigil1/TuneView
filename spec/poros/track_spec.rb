# frozen_string_literal: true

require 'rails_helper'

describe Track do
  context 'attributes' do
    it 'can be initialized from a reponse' do
      data = {
        items: [{
          track: {
            name: 'wonderwall',
            artists: [{ name: 'oasis' }],
            album: {
              name: 'album',
              images: [
                {},
                { url: 'google.com' }
              ]
            }
          }
        }]
      }

      track = Track.new(data)

      expect(track.title).to eq('wonderwall')
      expect(track.artist).to eq('oasis')
      expect(track.album).to eq('album')
      expect(track.cover_url).to eq('google.com')
    end
  end
end
