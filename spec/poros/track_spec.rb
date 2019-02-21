require 'rails_helper'

describe Track do
  context "attributes" do
    it 'can be initialized from a reponse' do
      data = {  id: 12345,
                name: "wonderwall",
                artists: [{name: "oasis"}],
                  album: {
                    name: "album",
                    images: [{}, {url: "google.com"}]
                  }
                }

      track = Track.new(data)

      expect(track.id).to eq(12345)
      expect(track.title).to eq("wonderwall")
      expect(track.artist).to eq("oasis")
      expect(track.album).to eq("album")
      expect(track.cover_url).to eq("google.com")
    end
  end

  context "instance methods" do
    it "can collapse a name with several spaces and a string" do
      data = {
                id: 12345,
                name: "my name is inigo montoya.",
                artists: [{name: "oasis"}],
                  album: {
                    name: "album",
                    images: [{}, {url: "google.com"}]
                  }
                }

      track = Track.new(data)

      expect(track.compress_title).to eq("my-name-is-inigo-montoya")
    end
  end
end
