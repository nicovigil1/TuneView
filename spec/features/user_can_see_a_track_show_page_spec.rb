require 'rails_helper'

describe "Track show page" do
  before(:each) do
    stub_login (@user = create(:user))
  end

  describe "can be accessed from" do
    it "top 5 tracks", :vcr do
      visit dashboard_path

      within "#top-5-tracks" do
        find(".track-1").click
      end

      expect(current_path).to include("/tracks/")
    end

    it "playlist show page", :vcr do
      visit playlists_path

      first(".teal.card").click
      expect(current_path).to include("/playlists/")

      find(".track-0").click

      expect(current_path).to include("/tracks/")
    end
  end
end
