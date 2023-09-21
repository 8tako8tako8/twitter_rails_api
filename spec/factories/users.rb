# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    name { SecureRandom.hex(8) }
    nickname { SecureRandom.hex(8) }
    uid { SecureRandom.uuid }
    confirmed_at { Time.zone.now }
  end
end
