# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower_user, class_name: 'User'
  belongs_to :followed_user, class_name: 'User'

  validates :follower_user_id, presence: true
  validates :followed_user_id, presence: true, uniqueness: { scope: :follower_user_id }
end
