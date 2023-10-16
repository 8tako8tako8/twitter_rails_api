# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :tweet, presence: true, uniqueness: { scope: :user }
end
