# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーション' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    it 'いいねが正しく作成できること' do
      favorite = FactoryBot.build(:favorite)
      expect(favorite).to be_valid
    end

    it '同一ユーザーが同一ツイートを複数回いいねできないこと' do
      FactoryBot.create(:favorite, user:, tweet:)
      duplicate_favorite = FactoryBot.build(:favorite, user:, tweet:)
      expect(duplicate_favorite).not_to be_valid
    end
  end
end
