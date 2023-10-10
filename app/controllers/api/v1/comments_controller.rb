# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      include Pagination
      before_action :authenticate_api_v1_user!, only: %i[create index]

      def index
        tweet = Tweet.find_by(id: params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        # TODO: ページネーションのために全件検索しているが、パフォーマンス改善のため、全件検索しないようにする
        all_comments = tweet.comments.order(created_at: :asc, id: :asc)

        @comments_paginated = all_comments.page(offset).per(limit)
        @pagination = pagination(@comments_paginated)
      end

      def create
        tweet = Tweet.find_by(id: comment_params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        comment = current_api_v1_user.comment(comment_params[:comment], tweet)
        if comment.persisted?
          render json: { comment: }, status: :created
        else
          render json: { errors: comment.errors }, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.permit(:comment, :tweet_id)
      end
    end
  end
end
