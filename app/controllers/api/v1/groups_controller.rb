# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[index create]

      def index
        @groups = search_groups.sort_by { |group| group[:group].id }
      end

      def create
        user = User.find_by(id: group_params[:user_id])
        unless user
          render json: { errors: 'ユーザーが見つかりません' }, status: :not_found
          return
        end

        group = current_api_v1_user.find_or_create_group(user)

        render json: { group: }, status: :ok
      end

      private

      def search_groups
        entries = Entry.where(group: current_api_v1_user.groups).where.not(user_id: current_api_v1_user.id).preload(:user, :group)

        entries.map do |entry|
          {
            group: entry.group,
            user: entry.user
          }
        end
      end

      def group_params
        params.permit(:user_id)
      end
    end
  end
end
