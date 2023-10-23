module Api
  module V1
    class BookmarksController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index create destroy]

      def index
        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        # TODO: ページネーションのために全件検索しているが、パフォーマンス改善のため、全件検索しないようにする
        all_bookmarks = current_api_v1_user.bookmarks.order(created_at: :desc, id: :desc)

        @bookmarks_paginated = all_bookmarks.page(offset).per(limit)
        @pagination = pagination(@bookmarks_paginated)
      end
    
      def create
        tweet = Tweet.find_by(params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        current_api_v1_user.bookmark(tweet)
        render json: { tweet: }, status: :ok
      end
    
      def destroy
        tweet = Tweet.find_by(params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        current_api_v1_user.cancel_bookmark(tweet)
        render json: { tweet: }, status: :ok
      end
    end
  end
end
