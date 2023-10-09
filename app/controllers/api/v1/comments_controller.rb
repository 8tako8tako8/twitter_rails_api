# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[create]

      def create
        tweet = Tweet.find_by(id: comment_params[:tweet_id])
        unless tweet
          render json: { errors: 'ツイートが見つかりません' }, status: :not_found
          return
        end

        comment = current_api_v1_user.comment(comment_params[:comment], tweet)
        if comment.save
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
