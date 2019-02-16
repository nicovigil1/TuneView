require 'rails_helper'


describe 'A visitor to our web app' do
  it 'can log into the page', :vcr do
    mock_hash = {
      credentials: {token: ENV['S_TEST_TOKEN'], refresh_token: ENV["REQUEST_TOKEN"]},
      info: {
        urls: {spotify: "google.com"},
        name: "mr_steal_yo_gurl",
        image: "https://www.google.com"
      }
    }
    testing = OmniAuth.config.add_mock(:spotify, mock_hash)

    visit '/'

    click_on "Log in to Spotify"

    expect(page).to have_content "Successfully signed in."

    expect(current_path).to eq dashboard_path

    expect(page).to have_content("Welcome, mr_steal_yo_gurl")
  end
end
