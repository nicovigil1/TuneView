require 'rails_helper'

describe "Spotify User Info" do
  context "attributes" do
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
    it "can hold a users top 5 artists (in objects)", :vcr do
      # pass current user in at initialization & store as @user
      user_info = SpotifyUserInfo.new(@current_user)
      expected = user_info.top_5_artists
      
      expect(expected.class).to eq(Array)
      expect(expected.first.class).to eq(Artist) 
      expect(expected.last.class).to eq(Artist) 
    end
    it "can hold a users top 5 tracks (in objects)", :vcr do
      user_info = SpotifyUserInfo.new(@current_user)
      expected = user_info.top_5_tracks
      
      expect(expected.class).to eq(Array)
      expect(expected.first.class).to eq(Track) 
      expect(expected.last.class).to eq(Track) 
    end
    it 'can hold a users most recently played song', :vcr do 
      user_info = SpotifyUserInfo.new(@current_user)
     
      expected = user_info.most_recent_song

      expect(expected.class).to eq(Track) 
    end 

    it 'can hold a users playlists', :vcr do 
      user_info = SpotifyUserInfo.new(@current_user)

      expect(user_info.playlists.first).to be_a(Playlist)
      expect(user_info.playlists.last).to be_a(Playlist)
    end

    it 'can get a users playlist tracks', :vcr do 
      user_info = SpotifyUserInfo.new(@current_user)
      expected = user_info.get_playlist_tracks("3CewmVIvc2e1svDfY7FupH")

      expect(expected.first).to be_a(Track)
    end

    xit 'can get a playlists stats', :vcr do 
      
    end 
  end
end