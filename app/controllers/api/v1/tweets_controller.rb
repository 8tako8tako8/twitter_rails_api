# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include Pagination
      before_action :authenticate_api_v1_user!, only: %i[index create]

      def index
        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        tweets = Tweet.order(created_at: :desc, id: :desc)

        @tweets_paginated = tweets.page(offset).per(limit)
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

      private

      def tweet_params
        params.permit(:tweet)
      end
    end
  end
end
