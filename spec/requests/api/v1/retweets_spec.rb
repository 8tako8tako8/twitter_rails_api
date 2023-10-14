require 'rails_helper'

RSpec.describe 'Api::V1::Retweets', type: :request do
  # 認証をスキップさせる
  before do
    allow_any_instance_of(Api::V1::RetweetsController).to receive(:authenticate_api_v1_user!).and_return(true)
  end

  describe 'POST /api/v1/tweets/:tweet_id/retweet' do
    subject { post(api_v1_tweet_retweet_path(tweet_id), headers:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }

    let!(:tweet_id) do
      tweet.id
    end

    # 認証情報をヘッダーに付与する
    before do
      auth_token = user.create_new_auth_token
      headers['access-token'] = auth_token['access-token']
      headers['client'] = auth_token['client']
      headers['uid'] = auth_token['uid']
    end

    it 'リツイートできること' do
      subject
      expect(response).to have_http_status(:ok)
      expect(tweet.retweets.reload.length).to eq 1
    end
  end

  describe 'DELETE /api/v1/tweets/:tweet_id/retweet' do
    subject { delete(api_v1_tweet_retweet_path(tweet_id), headers:) }

    let!(:user) { FactoryBot.create(:user) }
    let!(:tweet) { FactoryBot.create(:tweet) }
    let!(:retweet) { FactoryBot.create(:retweet, user:, tweet:) }

    let!(:tweet_id) do
      tweet.id
    end

    # 認証情報をヘッダーに付与する
    before do
      auth_token = user.create_new_auth_token
      headers['access-token'] = auth_token['access-token']
      headers['client'] = auth_token['client']
      headers['uid'] = auth_token['uid']
    end

    it 'リツイートが削除できること' do
      subject
      expect(response).to have_http_status(:ok)
      expect(tweet.retweets.reload.length).to eq 0
    end
  end
end
