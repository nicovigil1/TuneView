require 'rails_helper'

describe "Spotify User Info" do
  context "attributes" do
    it "can generate a users top 5 artists (in objects)" do
      # pass current user in at initialization & store as @user
      info = {username: "12184696969", 
        image_url: "https://bit.ly/2tlLmZc", 
        spotify_token: ENV["S_TEST_TOKEN"], 
        profile_url: "https://open.spotify.com/user/12184696969"}
      user = User.create(info)

      user_info = SpotifyUserInfo.new(user)
      expected = user_info.top_5_artists
      
      expect(expected.class).to eq(Array)
      expect(expected.first.class).to eq(Artist) 
      expect(expected.last.class).to eq(Artist) 
    end
  end
end
