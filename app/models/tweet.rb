# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :tweet, presence: true, length: { maximum: 200 }

  def created_by?(user)
    self.user.id == user.id
  end

  def count_retweets
    retweets.count
  end

  def count_favorites
    favorites.count
  end
end
