# frozen_string_literal: true

class Notification < ApplicationRecord
  after_create :send_email

  belongs_to :user
  belongs_to :subject, polymorphic: true

  enum action_type: { comment: 0, favorite: 1, retweet: 2 }
end
