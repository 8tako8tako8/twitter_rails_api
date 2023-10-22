# frozen_string_literal: true

tweets = @tweets.map do |tweet|
  hash = {
    id: tweet.id,
    tweet: tweet.tweet,
    created_at: tweet.created_at,
    updated_at: tweet.updated_at,
    is_retweeted: @user.retweet?(tweet),
    is_favorited: @user.favorite?(tweet),
    retweets: tweet.count_retweets,
    favorites: tweet.count_favorites
  }

  avatar_image_url = tweet.user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(tweet.user.avatar_image) : nil
  hash[:user] = {
    id: tweet.user.id,
    name: tweet.user.name,
    nickname: tweet.user.nickname,
    avatar_image_url:
  }
  hash[:image_url] = tweet.image.attached? ? Rails.application.routes.url_helpers.url_for(tweet.image) : nil

  hash
end

comments = @comments.map do |comment|
  hash = {
    id: comment.id,
    comment: comment.comment,
    created_at: comment.created_at,
    updated_at: comment.updated_at
  }

  avatar_image_url = comment.user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(comment.user.avatar_image) : nil
  hash[:user] = {
    id: comment.user.id,
    name: comment.user.name,
    nickname: comment.user.nickname,
    avatar_image_url:
  }

  hash
end

json.extract! @user, :id, :name, :nickname, :introduction, :location, :website_url, :birthdate
json.avatar_image_url @user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(@user.avatar_image) : nil
json.header_image_url @user.header_image.attached? ? Rails.application.routes.url_helpers.url_for(@user.header_image) : nil
json.isFollowing current_api_v1_user.following?(@user)
json.tweets tweets
json.comments comments
