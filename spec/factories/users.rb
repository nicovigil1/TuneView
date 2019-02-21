FactoryBot.define do
  factory :user do
    sequence :username do |n|
      "User #{n}"
    end

    sequence :profile_url do |n|
      "user-#{n}.com"
    end

    image_url { "https://bit.ly/2tlLmZc" }

    spotify_token { ENV["S_TEST_TOKEN"] }
    refresh_token { ENV["REQUEST_TOKEN"] }
    token_expire { 55.minutes.from_now }
  end
end
