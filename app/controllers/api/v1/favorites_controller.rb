# frozen_string_literal: true

module Api
  module V1
    class FavoritesController < ApplicationController
      # before_action :authenticate_api_v1_user!, only: %i[create destroy]

      def create
        tweet = Tweet.find_by(id: params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        current_api_v1_user.favorite(tweet)
        render json: { tweet: }, status: :ok
      end

      def destroy
        tweet = Tweet.find_by(id: params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        current_api_v1_user.cancel_favorite(tweet)
        render json: { tweet: }, status: :ok
      end
    end
  end
end
