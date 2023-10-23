# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      def create
        user = User.find_by(id: group_params[:user_id])
        unless user
          render json: { errors: 'ユーザーが見つかりません' }, status: :not_found
          return
        end

        group = current_api_v1_user.create_group(user)

        render json: { group: }, status: :created
      end

      private

      def group_params
        params.permit(:user_id)
      end
    end
  end
end
