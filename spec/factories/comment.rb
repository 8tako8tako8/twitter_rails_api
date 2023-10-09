# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    comment { 'テストコメント' }
    association :tweet
    association :user
  end
end
