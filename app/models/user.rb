class User < ApplicationRecord
  has_many :messages
  validates_presence_of :username, :spotify_token, :profile_url, :token_expire
  validates_uniqueness_of :username

  def token_expired?
    true if Time.now > token_expire
  end
end
