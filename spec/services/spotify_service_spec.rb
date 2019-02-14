require 'rails_helper'

describe SpotifyService do
  context "can make calls" do
    before(:each) do
      @info = {username: "12184696969",
        image_url: "https://bit.ly/2tlLmZc",
        spotify_token: "BQAfsthwdEBrywlUi_TyaBpz5Bb_iD0MLo0vk-E27eahZE57DpZzz0TJzn5kqi5ltIYDohLbUK5vGGwXSN_54h3Lw2SLNEgE-SpOdy2CpF-6yDJrJNzPaY2ZGP-ZK0Iu8AEJIkVuFlqEW0Tl9nSZST0lo8wLwghH4NUFvikwbczPTiXb9jLPAGvEfX2ApmBAAGRZ8IHAOFIAdUz1eGxFWPOMYaBu_h7OdeBGMoxcC4ROvLWXRR55NrRpIz5vykTrUhDEZBcyx4pFJYVLhcPh",
        profile_url: "https://open.spotify.com/user/12184696969"}
    end

    it "can access basic account info" do
      current_user = User.create(@info)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
      response = SpotifyService.user_data(current_user)

      expect(response[:email]).to be_truthy
    end

    it 'can find the top 5 artists per user' do
      current_user = User.create(@info)

      response = SpotifyService.top_5_artists(current_user)
      expect(response.length).to eq(5)
    end

    it 'can return the most recent played track' do
      user = User.create(@info)

      response = SpotifyService.most_recent_track(user)
      require "pry"; binding.pry
      # token has expired error message by the time our test suite gets to here
      # expect(response)
    end
  end
end
