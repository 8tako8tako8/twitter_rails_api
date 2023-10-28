# frozen_string_literal: true

bookmarks = @bookmarks_paginated.map do |bookmark|
  hash = {
    id: bookmark.tweet.id,
    tweet: bookmark.tweet.tweet,
    created_at: bookmark.tweet.created_at,
    updated_at: bookmark.tweet.updated_at
  }

  hash[:is_retweeted] = @user.retweet?(bookmark.tweet)

  hash[:is_favorited] = @user.favorite?(bookmark.tweet)

  hash[:is_bookmarked] = @user.bookmark?(bookmark.tweet)

  hash[:image_url] = bookmark.tweet.image.attached? ? Rails.application.routes.url_helpers.url_for(bookmark.tweet.image) : nil

  avatar_image_url = bookmark.tweet.user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(bookmark.tweet.user.avatar_image) : nil
  hash[:user] = {
    id: bookmark.tweet.user.id,
    name: bookmark.tweet.user.name,
    nickname: bookmark.tweet.user.nickname,
    avatar_image_url:
  }

  hash
end

json.bookmarks bookmarks
json.pagination @pagination
