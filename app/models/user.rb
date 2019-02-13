class User < ApplicationRecord
  validates_presence_of :username, :spotify_token, :profile_url
  validates_uniqueness_of :username
end   