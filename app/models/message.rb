class Message < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  validates_presence_of :body
  scope :custom_display, -> { order(:created_at).last(20) }
end
