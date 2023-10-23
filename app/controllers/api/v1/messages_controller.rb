# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
      def index
        group = Group.find_by(id: params[:group_id])
        unless group
          render json: { errors: 'グループが見つかりません' }, status: :not_found
          return
        end

        @messages = group.messages.order(created_at: :asc)
      end

      def create
        group = Group.find_by(id: params[:group_id])
        unless group
          render json: { errors: 'グループが見つかりません' }, status: :not_found
          return
        end

        message = group.message(current_api_v1_user, message_params)

        if message.persisted?
          render json: { message: }, status: :created
        else
          render json: { errors: message.errors }, status: :unprocessable_entity
        end
      end

      private

      def message_params
        params.permit(:message)
      end
    end
  end
end
