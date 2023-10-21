# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user
  has_one :notification, as: :subject, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 200 }

  def created_by?(user)
    self.user.id == user.id
  end
end
