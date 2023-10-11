# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  # 認証をスキップさせる
  before do
    allow_any_instance_of(Api::V1::CommentsController).to receive(:authenticate_api_v1_user!).and_return(true)
  end

  describe 'GET /api/v1/tweets/:tweet_id/comments' do
    let!(:tweet) { FactoryBot.create(:tweet, tweet: 'テストツイート') }

    let!(:tweet_id) do
      tweet.id
    end

    before do
      FactoryBot.create_list(:comment, 20, tweet:)
    end

    it 'コメント一覧が取得できること' do
      subject
      JSON.parse(response.body)
      comments = JSON.parse(response.body)['comments']
      expect(comments.length).to eq 10
    end
  end

  describe 'POST /api/v1/comments' do
    subject { post(api_v1_comments_path, headers:, params:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }
    let!(:params) { { comment: 'テストコメント', tweet_id: tweet.id } }

    # 認証情報をヘッダーに付与する
    before do
      auth_token = user.create_new_auth_token
      headers['access-token'] = auth_token['access-token']
      headers['client'] = auth_token['client']
      headers['uid'] = auth_token['uid']
    end

    it 'コメントが投稿できること' do
      subject
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /api/v1/comments/:id' do
    subject { delete(api_v1_comment_path(id), headers:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }
    let!(:comment) { FactoryBot.create(:comment, user:, tweet:) }

    let!(:id) do
      comment.id
    end

    # 認証情報をヘッダーに付与する
    before do
      auth_token = user.create_new_auth_token
      headers['access-token'] = auth_token['access-token']
      headers['client'] = auth_token['client']
      headers['uid'] = auth_token['uid']
    end

    it 'コメントが削除できること' do
      subject
      expect(response).to have_http_status(:ok)
      expect(tweet.comments.reload.count).to eq 0
    end
  end
end
