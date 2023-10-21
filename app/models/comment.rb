# frozen_string_literal: true

class Comment < ApplicationRecord
  after_create_commit :create_notification

  belongs_to :tweet
  belongs_to :user
  has_one :notification, as: :subject, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 200 }

  def created_by?(user)
    self.user.id == user.id
  end

  private
  
  def create_notification
    return if tweet.user.id == user.id

    Notification.create(subject: self, user: tweet.user, action_type: Notification.action_types[:comment])
  end
end
