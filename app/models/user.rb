# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, :spotify_token, :profile_url, presence: true
  validates :username, uniqueness: true
end
