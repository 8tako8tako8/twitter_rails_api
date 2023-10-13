# frozen_string_literal: true

comments = @comments_paginated.map do |comment|
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

json.comments comments
json.pagination @pagination
