# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tweets', type: :request do
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
end
