# frozen_string_literal: true

class Notification < ApplicationRecord
  after_create :send_email

  belongs_to :user
  belongs_to :subject, polymorphic: true

  enum action_type: { comment: 0, favorite: 1, retweet: 2 }

  def send_email
    if comment?
      NotificationMailer.comment(self).deliver_now
    elsif favorite?
      NotificationMailer.favorite(self).deliver_now
    elsif retweet?
      NotificationMailer.retweet(self).deliver_now
    end
  end
end
