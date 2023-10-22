# frozen_string_literal: true

notifications = @notifications_paginated.map do |notification|
  hash = {
    id: notification.id,
    subject_type: notification.subject_type.downcase,
    created_at: notification.created_at,
    updated_at: notification.updated_at
  }

  avatar_image_url = notification.subject.user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(notification.subject.user.avatar_image) : nil
  hash[:user] = {
    id: notification.subject.user.id,
    name: notification.subject.user.name,
    nickname: notification.subject.user.nickname,
    avatar_image_url:
  }

  hash
end

avatar_image_url = @user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(@user.avatar_image) : nil
user = {
  id: @user.id,
  name: @user.name,
  nickname: @user.nickname,
  avatar_image_url:
}

json.notifications notifications
json.pagination @pagination
json.user user
