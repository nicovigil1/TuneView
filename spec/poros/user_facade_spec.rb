require "rails_helper"

describe "User Facade" do
    before(:each) do
      @info = {username: "12184696969",
        image_url: "https://bit.ly/2tlLmZc",
        spotify_token: ENV["S_TEST_TOKEN"],
        refresh_token: ENV["REQUEST_TOKEN"],
        profile_url: "https://open.spotify.com/user/12184696969"}

      @current_user = User.create(@info)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@current_user)
      SpotifyService.refresh_token(@current_user)
    end

    it "can generate top 5 artists for a user", :vcr do
      expected = UserFacade.top_5_artists(@current_user)

      expect(expected.class).to eq(Array)
      expect(expected.count).to eq(5)
      expect(expected.first.class).to eq(Artist) 
      expect(expected.last.class).to eq(Artist) 
    end

    it 'can return the most recent played track', :vcr do
      response = UserFacade.most_recent_track(@current_user)

      expect(response).to be_a(Track)
    end

    it 'can return a users playlists', :vcr do 
      response = UserFacade.playlists(@current_user)

      expect(response.first).to be_a(Playlist)
      expect(response.last).to be_a(Playlist)
    end 

end
