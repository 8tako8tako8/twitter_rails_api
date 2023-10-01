# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include Pagination
      before_action :authenticate_api_v1_user!, only: %i[index create show destroy]

      def index
        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        # TODO: ページネーションのために全件検索しているが、パフォーマンス改善のため、全件検索しないようにする
        all_tweets = Tweet.with_attached_image.order(created_at: :desc, id: :desc)

        @tweets_paginated = all_tweets.page(offset).per(limit)
        @pagination = pagination(@tweets_paginated)
      end

      def create
        tweet = current_api_v1_user.tweets.build(tweet_params)
        if tweet.save
          render json: { tweet: }, status: :created
        else
          render json: { errors: tweet.errors }, status: :unprocessable_entity
        end
      end

      def show
        @tweet = Tweet.find(params[:id])
      end

      def destroy
        tweet_id = params[:id]
        tweet = Tweet.find(tweet_id)

        # if tweet.user.id != current_api_v1_user.id
        #   render json: { errors: 'ツイートした本人でないためツイートを削除できません' }, status: :unauthorized
        # end

        if tweet.destroy
          render json: { tweet: }, status: :ok
        else
          render json: { errors: tweet.errors }, status: :unprocessable_entity
        end
      end

      private

      def tweet_params
        params.permit(:tweet)
      end

      def tweet_image_url(tweet)
        url_for(tweet.image) if tweet.image.attached?
      end
    end
  end
end
