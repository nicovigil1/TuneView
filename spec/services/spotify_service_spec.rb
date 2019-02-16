require 'rails_helper'

describe SpotifyService do
  context "can make calls" do
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

    it "can access basic account info" do
      response = SpotifyService.user_data(@current_user)

      expect(response[:email]).to be_truthy
    end

    it 'can find the top 5 artists per user' do
      response = SpotifyService.top_5_artists(@current_user)
      
      expect(response.length).to eq(5)
    end 
    # after this is run you have to change your development variables
    xit 'can refresh a users token' do 
      info = {username: "12184696969", 
        image_url: "https://bit.ly/2tlLmZc", 
        spotify_token: ENV["S_TEST_TOKEN"], 
        refresh_token: ENV["REQUEST_TOKEN"],
        profile_url: "https://open.spotify.com/user/12184696969"}

      current_user = User.create(info)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)

      previous_token = current_user.spotify_token
      response = SpotifyService.refresh_token(current_user)

      expect(response).to_not eq(previous_token)
      expect(response).to eq(current_user.spotify_token)
    end 

    # xit 'can return the most recent played track' do
    #   response = SpotifyService.most_recent_track(@current_user)
    #   # token has expired error message by the time our test suite gets to here
    #   # expect(response)
    # end

    it 'can return a users playlists' do 
      response = SpotifyService.find_playlists(@current_user)

      expect(response.first[:id]).to be_truthy
    end 
  end
end
