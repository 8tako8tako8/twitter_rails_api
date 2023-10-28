# frozen_string_literal: true

groups = @groups.map do |group|
  hash = {
    id: group[:group].id
  }

  avatar_image_url = group[:user].avatar_image.attached? ? Rails.application.routes.url_helpers.url_for(group[:user].avatar_image) : nil

  hash[:user] = {
    id: group[:user].id,
    name: group[:user].name,
    nickname: group[:user].nickname,
    avatar_image_url:
  }

  hash
end

json.groups groups
