require "rails_helper" 

describe "A User" do
  context "on the homepage" do
    it "sees a link to view their playlists in the nav", :vcr do
      info = {username: "12184696969", 
              image_url: "https://bit.ly/2tlLmZc", 
              spotify_token: ENV["S_TEST_TOKEN"], 
              refresh_token: ENV["REQUEST_TOKEN"],
              profile_url: "https://open.spotify.com/user/12184696969"}
      user = User.create(info)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within(".right.menu") do
        expect(page).to have_content("Playlists") 
        click_on "Playlists"
      end 

      expect(current_path).to eq(playlists_path) 
    end
  end

  context "on playlists index" do 
    it "sees all of their playlists", :vcr do
      info = {username: "12184696969", 
              image_url: "https://bit.ly/2tlLmZc", 
              spotify_token: ENV["S_TEST_TOKEN"], 
              refresh_token: ENV["REQUEST_TOKEN"],
              profile_url: "https://open.spotify.com/user/12184696969"}
      user = User.create(info)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit dashboard_path
  
      within(".right.menu") do
        expect(page).to have_content("Playlists") 
        click_on "Playlists"
      end 
  
      expect(page).to have_content("Click a playlist for its stats!") 
      expect(page).to have_css(".playlists")
    end 
  end
end
