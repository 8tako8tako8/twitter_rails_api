# frozen_string_literal: true

USER_COUNT = 1 
TWEET_COUNT = 1 

ApplicationRecord.transaction do
  users = []
  USER_COUNT.times do |i|
    user = User.new(
      email: Faker::Internet.unique.email, password: 'password',
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

  # ユーザー0が画像付きのツイートを投稿
  user0_tweet = users[0].tweets.build(tweet: 'いい天気です！')
  image_path = Rails.root.join('db/seeds/sky.jpg')
  if File.exist?(image_path)
    file = File.open(image_path)
    user0_tweet.image.attach(io: file, filename: 'sky.jpg', content_type: 'image/jpeg')
  end
  user0_tweet.save!
end
