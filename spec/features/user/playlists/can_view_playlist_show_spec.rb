require 'rails_helper'

describe "Playlist Show Page" do
  context "can be accessed from it's index page" do
    it "when a playlist is clicked", :vcr do
      info = {username: "12184696969",
        image_url: "https://bit.ly/2tlLmZc",
        spotify_token: ENV["S_TEST_TOKEN"],
        refresh_token: ENV["REQUEST_TOKEN"],
        profile_url: "https://open.spotify.com/user/12184696969",
        token_expire: 55.minutes.from_now
      }
      user = User.create(info)
      stub_login(user)

      visit playlists_path

      first(".teal.card").click
      expect(current_path).to include("/playlists/")
    end
  end
end
