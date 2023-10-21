# frozen_string_literal: true

module Api
  module V1
    class FollowsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[create destroy]

      def create
        user = User.find(params[:user_id])

        unless user
          render json: { errors: 'ユーザーが見つかりません' }, status: :not_found
          return
        end

        if user == current_api_v1_user
          render json: { errors: '自分自身をフォローすることはできません' }, status: :bad_request
          return
        end

        if current_api_v1_user.follow(user)
          render json: { }, status: :no_content
        else
          render json: { errors: 'フォローに失敗しました' }, status: :internal_server_error
        end
      end

      def destroy
        user = User.find(params[:user_id])

        unless user
          render json: { errors: 'ユーザーが見つかりません' }, status: :not_found
          return
        end

        if user == current_api_v1_user
          render json: { errors: '自分自身をフォローすることはできません' }, status: :bad_request
          return
        end

        if current_api_v1_user.cancel_follow(user)
          render status: :no_content
        else
          render json: { errors: 'フォローに失敗しました' }, status: :internal_server_error
        end
      end
    end
  end
end
