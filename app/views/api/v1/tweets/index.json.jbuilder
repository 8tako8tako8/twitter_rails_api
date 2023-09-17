# frozen_string_literal: true

tweets = @tweets_paginated.map do |tweet|
  hash = {
    id: tweet.id,
    tweet: tweet.tweet,
    created_at: tweet.created_at,
    updated_at: tweet.updated_at
  }
  hash[:user] = {
    id: tweet.user.id,
    name: tweet.user.name,
    nickname: tweet.user.nickname
  }
  hash[:image_url] = tweet.image.attached? ? Rails.application.routes.url_helpers.url_for(tweet.image) : nil

  hash
end

json.tweets tweets
json.pagination @pagination
