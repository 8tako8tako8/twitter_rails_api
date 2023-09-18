# frozen_string_literal: true

user = { id: @tweet.user.id, name: @tweet.user.name, nickname: @tweet.user.nickname }

json.id @tweet.id
json.tweet @tweet.tweet
json.image_url @tweet.image.attached? ? Rails.application.routes.url_helpers.url_for(@tweet.image) : nil
json.created_at @tweet.created_at
json.updated_at @tweet.updated_at
json.user user
