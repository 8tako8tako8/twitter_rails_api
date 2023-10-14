# frozen_string_literal: true

tweets = @tweets_paginated.map do |tweet|
  hash = {
    id: tweet.id,
    tweet: tweet.tweet,
    created_at: tweet.created_at,
    updated_at: tweet.updated_at
  }

  avatar_image_url = tweet.user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(tweet.user.avatar_image) : nil
  hash[:user] = {
    id: tweet.user.id,
    name: tweet.user.name,
    nickname: tweet.user.nickname,
    avatar_image_url:
  }

  hash[:image_url] = tweet.image.attached? ? Rails.application.routes.url_helpers.url_for(tweet.image) : nil

  hash[:retweets] = tweet.count_retweets

  hash
end

json.tweets tweets
json.pagination @pagination
