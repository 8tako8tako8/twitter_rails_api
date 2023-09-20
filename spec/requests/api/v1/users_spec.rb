require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  # 認証をスキップさせる
  before do
    allow_any_instance_of(Api::V1::UsersController).to receive(:authenticate_api_v1_user!).and_return(true)
  end

  describe 'GET /api/v1/users/:user_id' do
    let!(:user) { FactoryBot.create(:user, nickname: 'テストユーザー') }

    let!(:user_id) do
      user.id
    end

    before do
      FactoryBot.create(:tweet, user: user, tweet: 'テストツイート')
    end

    it 'ユーザー情報が取得できること' do
      subject
      res = JSON.parse(response.body)
      expect(res['nickname']).to eq 'テストユーザー'
    end

    it 'ユーザーのツイート一覧が取得できること' do
      subject
      res = JSON.parse(response.body)
      expect(res['tweets'].first['tweet']).to eq 'テストツイート'
    end
  end
end