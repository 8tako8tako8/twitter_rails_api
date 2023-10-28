# frozen_string_literal: true

avatar_image_url = @tweet.user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(@tweet.user.avatar_image) : nil
tweet_user = {
  id: @tweet.user.id,
  name: @tweet.user.name,
  nickname: @tweet.user.nickname,
  avatar_image_url:
}

json.id @tweet.id
json.tweet @tweet.tweet
json.image_url @tweet.image.attached? ? Rails.application.routes.url_helpers.url_for(@tweet.image) : nil
json.created_at @tweet.created_at
json.updated_at @tweet.updated_at
json.user tweet_user
json.is_retweeted @user.retweet?(@tweet)
json.is_favorited @user.favorite?(@tweet)
json.is_bookmarked @user.bookmark?(@tweet)
json.retweets @tweet.count_retweets
json.favorites @tweet.count_favorites
