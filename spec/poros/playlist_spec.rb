require "rails_helper"

describe "Playlists" do
  context "attributes" do
    it "can be generated from hardcoded hash" do
      info = {id: 1,
              name: "name", 
              collaborative: false,
              images: ["img1", "img2"], 
              public: true, 
              tracks: {href: "google.com", total: 4}}
      playlist = Playlist.new(info)
      
      expect(playlist.id).to eq(1)
      expect(playlist.collaborative).to eq(false)
      expect(playlist.images.first).to eq("img1")
      expect(playlist.name).to eq("name")
      expect(playlist.public).to eq(true)
      expect(playlist.tracks).to eq("google.com")
      expect(playlist.track_count).to eq(4)
    end
  end

  context "instance methods" do 
    it "can collapse a name with several spaces and a string" do 
      info = {id: 1,
        name: "my name is inigo montoya.", 
        collaborative: false,
        images: ["img1", "img2"], 
        public: true, 
        tracks: {href: "google.com", total: 4}}
      playlist = Playlist.new(info)

      expect(playlist.compress_name).to eq("my-name-is-inigo-montoya")
    end
  end 
end
