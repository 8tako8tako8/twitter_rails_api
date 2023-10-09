# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'バリデーション' do
    it 'コメントが正しく作成できること' do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end

    it 'コメントがnilの場合にエラーになること' do
      comment = FactoryBot.build(:comment, comment: nil)
      expect(comment).not_to be_valid
    end

    it 'コメントの文字数が200字を超えた場合にエラーとなること' do
      comment = FactoryBot.build(:comment, comment: 'a' * 201)
      expect(comment).not_to be_valid
    end
  end
end
