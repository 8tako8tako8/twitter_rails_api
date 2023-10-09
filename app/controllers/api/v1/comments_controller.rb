# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[create]

      def create
        tweet = Tweet.find(comment_params[:tweet_id])
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
