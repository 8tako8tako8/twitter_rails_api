# frozen_string_literal: true

json.extract! @user, :id, :email, :name, :nickname
json.avatar_image_url @user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(@user.avatar_image) : nil
