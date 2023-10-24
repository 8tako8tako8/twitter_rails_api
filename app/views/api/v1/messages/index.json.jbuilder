# frozen_string_literal: true

messages = @messages.map do |message|
  hash = {
    id: message.id,
    message: message.message,
    created_at: message.created_at,
    updated_at: message.updated_at
  }

  avatar_image_url = message.user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(message.user.avatar_image) : nil
  hash[:user] = {
    id: message.user.id,
    name: message.user.name,
    nickname: message.user.nickname,
    avatar_image_url:
  }

  hash
end

json.messages messages
