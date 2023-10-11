# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Pagination
      before_action :authenticate_api_v1_user!, only: %i[show]

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

      private

      def user_params
        params.permit(:nickname, :introduction, :location, :website_url, :birthdate)
      end
    end
  end
end
