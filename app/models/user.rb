# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :active_relationships, class_name: 'Follow', foreign_key: 'follower_user_id', dependent: :destroy, inverse_of: :follower_user
  has_many :followings, through: :active_relationships, source: :followed_user
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_user_id', dependent: :destroy, inverse_of: :followed_user
  has_many :followers, through: :passive_relationships, source: :follower_user
  has_many :notifications, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :groups, through: :entries
  has_one_attached :avatar_image
  has_one_attached :header_image

  validates :name, presence: true, length: { maximum: 20 }
  validates :nickname, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 100 }
  validates :location, length: { maximum: 10 }
  # TODO: サインイン時にallow_blankが適応されずバリデーションエラーとなるので一旦コメントアウト
  # validates :website_url, format: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true

  def logical_delete
    update(deleted_at: Time.current)
  end

  def logical_deleted?
    deleted_at.present?
  end

  def same?(user)
    id == user.id
  end

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

  def bookmark(tweet)
    bookmarks.find_or_create_by(tweet:)
  end

  def cancel_bookmark(tweet)
    bookmarks.find_by(tweet:)&.destroy
  end

  def bookmark?(tweet)
    bookmarks.exists?(tweet:)
  end

  def follow(user)
    return if same?(user)

    active_relationships.find_or_create_by(followed_user_id: user.id)
  end

  def cancel_follow(user)
    return if same?(user)

    ar = active_relationships.find_by(followed_user_id: user.id)

    #
    # NOTE:
    #   active_relationships が見つからない場合、フォロー解除済みとしてtrueを返す
    #
    return true unless ar

    ar.destroy
  end

  def following?(user)
    followings.exists?(user.id)
  end

  def find_or_create_group(user)
    common_group = common_group(user)

    # グループが存在する場合はそのグループを返す
    return common_group if common_group

    group = Group.create
    group.entries.create([{ user_id: id }, { user_id: user.id }])

    group
  end

  def common_group(user)
    (groups & user.groups).first
  end
end
