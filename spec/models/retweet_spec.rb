require 'rails_helper'

RSpec.describe Retweet, type: :model do
  describe 'バリデーション' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    it 'リツイートが正しく作成できること' do
      retweet = FactoryBot.build(:retweet)
      expect(retweet).to be_valid
    end

    it '同一ユーザーが同一ツイートを複数回リツイートできないこと' do
      FactoryBot.create(:retweet, user: user, tweet: tweet)
      duplicate_retweet = FactoryBot.build(:retweet, user: user, tweet: tweet)
      expect(duplicate_retweet).not_to be_valid
    end
  end
end
