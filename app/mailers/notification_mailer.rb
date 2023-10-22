# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  def comment(notification)
    @notification = notification
    mail(to: @notification.user.email, subject: 'コメントのお知らせ')
  end

  def favorite(notification)
    @notification = notification
    mail(to: @notification.user.email, subject: 'いいねのお知らせ')
  end

  def retweet(notification)
    @notification = notification
    mail(to: @notification.user.email, subject: 'リツイートのお知らせ')
  end
end
