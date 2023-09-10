# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'バリデーション' do
    it 'ツイートが正しく作成されること' do
      tweet = FactoryBot.build(:tweet)
      expect(tweet).to be_valid
    end

    it 'ツイートがnilの場合にエラーになること' do
      tweet = FactoryBot.build(:tweet, tweet: nil)
      expect(tweet).not_to be_valid
    end

    it 'ツイートが200文字を超えた場合にエラーになること' do
      tweet = FactoryBot.build(:tweet, tweet: 'a' * 201)
      expect(tweet).not_to be_valid
    end
  end
end
