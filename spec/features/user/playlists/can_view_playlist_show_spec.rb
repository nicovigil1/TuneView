require 'rails_helper'

describe "Playlist Show Page" do
  context "can be accessed from it's index page" do
    xit "when a playlist is clicked", :vcr do
      info = {username: "12184696969", 
              image_url: "https://bit.ly/2tlLmZc", 
              spotify_token: ENV["S_TEST_TOKEN"], 
              refresh_token: ENV["REQUEST_TOKEN"],
              profile_url: "https://open.spotify.com/user/12184696969"}
      user = User.create(info)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit playlists_path

      find("#playlist-1").click
      require 'pry'; binding.pry
      expect(current_path).to eq(playlist_path()) 
    end
  end
end
