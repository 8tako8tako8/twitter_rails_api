# frozen_string_literal: true

json.extract! @user, :id, :name, :nickname, :introduction, :location, :website_url
json.avatar_image_url @user.avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(@user.avatar_image) : nil
json.header_image_url @user.header_image.attached? ? Rails.application.routes.url_helpers.url_for(@user.header_image) : nil
