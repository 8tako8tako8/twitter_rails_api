# frozen_string_literal: true

FactoryBot.define do
  factory :retweet do
    association :user
    association :tweet
  end
end
