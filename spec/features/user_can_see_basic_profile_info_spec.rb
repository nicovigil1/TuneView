require 'rails_helper'

describe "As a user" do
  before(:each) do
    info = {username: "12184696969",
      image_url: "https://bit.ly/2tlLmZc",
      spotify_token: ENV["S_TEST_TOKEN"],
      refresh_token: ENV["REQUEST_TOKEN"],
      profile_url: "https://open.spotify.com/user/12184696969",
      token_expire: 55.minutes.from_now
    }
    @user = User.create(info)
    stub_login(@user)
  end

  describe "When I visit my dashbaord ('/dashboard')" do
    it "I should see my spotify username and profile image", :vcr do
      visit dashboard_path

      expect(page).to have_content("Welcome, #{@user.username}")
      expect(page).to have_css("img[src='#{@user.image_url}']")
    end
  end
end
