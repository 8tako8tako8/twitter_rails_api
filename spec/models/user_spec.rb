# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'ユーザーが正しく作成されること' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    describe 'name' do
      it 'nameがnilの場合にエラーになること' do
        user = FactoryBot.build(:user, name: nil)
        expect(user).not_to be_valid
      end

      it 'nameが20文字を超えた場合にエラーになること' do
        user = FactoryBot.build(:user, name: 'a' * 21)
        expect(user).not_to be_valid
      end
    end

    describe 'nickname' do
      it 'nicknameがnilの場合にエラーになること' do
        user = FactoryBot.build(:user, nickname: nil)
        expect(user).not_to be_valid
      end

      it 'nicknameが20文字を超えた場合にエラーになること' do
        user = FactoryBot.build(:user, nickname: 'a' * 21)
        expect(user).not_to be_valid
      end
    end

    describe 'introduction' do
      it 'introductionが100文字を超えた場合にエラーになること' do
        user = FactoryBot.build(:user, introduction: 'a' * 101)
        expect(user).not_to be_valid
      end
    end

    describe 'location' do
      it 'locationが100文字を超えた場合にエラーになること' do
        user = FactoryBot.build(:user, location: 'a' * 11)
        expect(user).not_to be_valid
      end
    end
  end
end
