# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  def message(user, message)
    message = messages.build(message)
    message.user = user
    message.save

    message
  end
end
