# frozen_string_literal: true

bookmarks = @bookmarks_paginated.map do |bookmark|
  hash = {
    id: bookmark.id,
    created_at: bookmark.created_at,
    updated_at: bookmark.updated_at
  }

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
