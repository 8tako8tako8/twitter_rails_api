# frozen_string_literal: true

class Retweet < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_one :notification, as: :subject, dependent: :destroy

  validates :tweet, presence: true, uniqueness: { scope: :user }
end
