FactoryBot.define do
  factory :user do
    sequence :username do |n|
      "User #{n}"
    end

    sequence :profile_url do |n|
      "user-#{n}.com"
    end

    image_url { "https://bit.ly/2tlLmZc" }
    spotify_token { Faker::Crypto.sha1 }

    # sequence :uid do |n|
    #   n
    # end
  end
end
