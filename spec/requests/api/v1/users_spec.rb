# frozen_string_literal: true

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
    let!(:tweet) { FactoryBot.create(:tweet, user:, tweet: 'テストツイート') }
    let!(:comment) { FactoryBot.create(:comment, user:, tweet:, comment: 'テストコメント') }

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

    it 'ユーザーのコメント一覧が取得できること' do
      subject
      res = JSON.parse(response.body)
      expect(res['comments'].first['comment']).to eq 'テストコメント'
    end
  end

  describe 'PUT /api/v1/profile' do
    let!(:user) { FactoryBot.create(:user) }

    # 認証情報をヘッダーに付与する
    before do
      auth_token = user.create_new_auth_token
      headers['access-token'] = auth_token['access-token']
      headers['client'] = auth_token['client']
      headers['uid'] = auth_token['uid']
    end

    context '正しいリクエストパラメータの場合' do
      user_params = { nickname: '更新後ニックネーム', introduction: 'よろしくお願いします！', location: '東京都', birthdate: '1990-01-01', website_url: 'https://example.com' }

      subject { put(api_v1_profile_path, headers:, params:) }

      let!(:params) { user_params }

      it 'ユーザー情報が更新できること' do
        subject
        expect(user.reload.nickname).to eq user_params[:nickname]
        expect(user.reload.introduction).to eq user_params[:introduction]
        expect(user.reload.location).to eq user_params[:location]
        expect(user.reload.birthdate.to_s).to eq user_params[:birthdate]
        expect(user.reload.website_url).to eq user_params[:website_url]
      end
    end

    context '不正なリクエストパラメータの場合' do
      user_params = { name: 'テストネーム' }

      subject { put(api_v1_profile_path, headers:, params:) }

      let!(:params) { user_params }

      it 'ユーザーネームが更新できないこと' do
        subject
        expect(user.reload.name).not_to eq user_params[:name]
      end
    end
  end
end
