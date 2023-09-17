# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tweets', type: :request do
  # 認証をスキップさせる
  before do
    allow_any_instance_of(Api::V1::TweetsController).to receive(:authenticate_api_v1_user!).and_return(true)
  end

  describe 'GET /api/v1/tweets' do
    before do
      FactoryBot.create_list(:tweet, 20)
    end

    it 'ツイートの一覧が取得できること' do
      subject
      tweets = JSON.parse(response.body)['tweets']
      expect(tweets.length).to eq 10
    end

    it 'ページネーション情報が取得できること' do
      subject
      pagination = JSON.parse(response.body)['pagination']
      expect(pagination['total_count']).to eq 20
      expect(pagination['limit_value']).to eq 10
      expect(pagination['total_pages']).to eq 2
      expect(pagination['current_page']).to eq 1
    end
  end

  describe 'POST /api/v1/tweets' do
    subject { post(api_v1_tweets_path, headers:, params:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:params) { { tweet: 'テストツイート' } }

    # 認証情報をヘッダーに付与する
    before do
      auth_token = user.create_new_auth_token
      headers['access-token'] = auth_token['access-token']
      headers['client'] = auth_token['client']
      headers['uid'] = auth_token['uid']
    end

    it 'ツイートが投稿できること' do
      subject
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET /api/v1/tweets/:tweet_id' do
    let!(:tweet) { FactoryBot.create(:tweet, tweet: 'テストツイート') }

    let!(:tweet_id) do
      tweet.id
    end
      
    it 'ツイート詳細が取得できること' do
      subject
      res = JSON.parse(response.body)
      expect(res['tweet']).to eq 'テストツイート'
    end
  end
end
