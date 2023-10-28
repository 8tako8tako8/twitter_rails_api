# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Pagination
      before_action :authenticate_api_v1_user!, only: %i[show update]

      def show
        @user = User.find(params[:id])
        @tweets = @user.tweets.limit(10).with_attached_image.order(created_at: :desc, id: :desc)
        @comments = @user.comments.limit(10).order(created_at: :desc, id: :desc)
      end

      def update
        @user = current_api_v1_user

        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def user_session
        if current_api_v1_user.deleted_at.present?
          render json: nil, status: :forbidden
          return
        end

        avatar_image_url = current_api_v1_user&.avatar_image&.attached? ? Rails.application.routes.url_helpers.url_for(current_api_v1_user.avatar_image) : nil
        user = current_api_v1_user&.as_json&.merge(avatar_image_url: avatar_image_url)

        render json: user, status: :ok
      end

      private

      def user_params
        params.permit(:nickname, :introduction, :location, :website_url, :birthdate)
      end
    end
  end
end
