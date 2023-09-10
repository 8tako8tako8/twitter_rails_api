# frozen_string_literal: true

module Api
  module V1
    class ImagesController < ApplicationController
      before_action :authenticate_api_v1_user!, only: [:create]

      def create
        tweet = Tweet.find(params[:tweet_id])

        # ツイートしたユーザーと異なる場合に画像を登録させない
        return render json: { error: 'Not authorized' }, status: :forbidden unless tweet.user.id == current_api_v1_user&.id

        tweet.image.attach(params[:image])
        if tweet.image.attached?
          render json: { message: '登録に成功しました' }, status: :created
        else
          render json: { errors: ['画像のアップロードに失敗しました'] }, status: :unprocessable_entity
        end
      end
    end
  end
end
