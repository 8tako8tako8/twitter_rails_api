# frozen_string_literal: true

USER_COUNT = 5
TWEET_COUNT = 5

ApplicationRecord.transaction do
  users = []
  USER_COUNT.times do |i|
    user = User.new(
      email: "user#{i}@example.com", password: 'password',
      password_confirmation: 'password', name: "UserName#{i}", nickname: "UserNickname#{i}",
      uid: SecureRandom.uuid, confirmed_at: Time.zone.now
    )
    user.save || Rails.logger.debug(user.errors.full_messages)
    users << user
  end

  TWEET_COUNT.times do |_i|
    users.each do |user|
      user.tweets.create!(tweet: "#{user.name}によるツイートです。")
    end
  end
end
