require 'rails_helper'


describe 'A visitor to our web app' do
  it 'can log into the page' do
    user = User.new(username: "mr_steal_yo_gurl",
      image_url: "https://www.google.com",
      spotify_token: "4329432bgb",
      profile_url: "google.com"
    )

    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(
      credentials: {token: "4329432bgb"},
      info: {
        urls: {spotify: "google.com"},
        nickname: "mr_steal_yo_gurl",
        image: "https://www.google.com"
      })

    visit '/'
    click_on "Log in to Spotify"

    expect(page).to have_content "Successfully signed in."

    expect(current_path).to eq dashboard_path

    expect(page).to have_content("Welcome, #{user.username}")

  end
end
