# frozen_string_literal: true

module Api
  module V1
    class RetweetsController < ApplicationController

      def create
        tweet = Tweet.find_by(id: params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        current_api_v1_user.retweet(tweet)
        render json: { tweet: }, status: :created
      end
    end
  end
end
