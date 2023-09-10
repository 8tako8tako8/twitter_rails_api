# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    tweet { 'テストツイート' }
    association :user
  end
end
