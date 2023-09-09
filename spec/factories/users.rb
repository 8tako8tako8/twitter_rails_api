# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    name { 'テストユーザー' }
    uid { SecureRandom.uuid }
    confirmed_at { Time.zone.now }
  end
end
