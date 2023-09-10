# frozen_string_literal: true

class Tweet < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :tweet, presence: true, length: { maximum: 200 }
end
