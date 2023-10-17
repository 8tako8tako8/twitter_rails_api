# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :avatar_image
  has_one_attached :header_image

  validates :name, presence: true, length: { maximum: 20 }
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 100 }
  validates :location, length: { maximum: 10 }
  # TODO: サインイン時にallow_blankが適応されずバリデーションエラーとなるので一旦コメントアウト
  # validates :website_url, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true

  def comment(comment, tweet)
    comments.create(comment:, tweet:)
  end

  def retweet(tweet)
    retweets.find_or_create_by(tweet:)
  end

  def cancel_retweet(tweet)
    retweets.find_by(tweet:)&.destroy
  end

  def retweet?(tweet)
    retweets.exists?(tweet:)
  end

  def favorite(tweet)
    favorites.find_or_create_by(tweet:)
  end

  def cancel_favorite(tweet)
    favorites.find_by(tweet:)&.destroy
  end

  def favorite?(tweet)
    favorites.exists?(tweet:)
  end
end
