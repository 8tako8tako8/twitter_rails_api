# frozen_string_literal: true

users = @users.map do |user|
  avatar_image_url = user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(user.avatar_image) : nil

  {
    id: user.id,
    name: user.name,
    nickname: user.nickname,
    avatar_image_url:
  }
end

json.users users
