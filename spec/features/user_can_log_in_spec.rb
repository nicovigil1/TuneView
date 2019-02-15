require 'rails_helper'


describe 'A visitor to our web app' do
  it 'can log into the page' do
    mock_hash = {
      credentials: {token: ENV['S_TEST_TOKEN']},
      info: {
        urls: {spotify: "google.com"},
        name: "mr_steal_yo_gurl",
        image: "https://www.google.com"
      }
    }

    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(mock_hash)

    visit '/'
    VCR.use_cassette('spotify-oauth-login') do
      click_on "Log in to Spotify"

      expect(page).to have_content "Successfully signed in."

      expect(current_path).to eq dashboard_path

      expect(page).to have_content("Welcome, mr_steal_yo_gurl")
    end
  end
end
