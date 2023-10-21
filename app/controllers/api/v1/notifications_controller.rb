# frozen_string_literal: true

module Api
  module V1
    class NotificationsController < ApplicationController
      include Pagination
      before_action :authenticate_api_v1_user!, only: [:index]

      def index
        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        all_notifications = current_api_v1_user.notifications.order(created_at: :desc, id: :desc)

        @notifications_paginated = all_notifications.page(offset).per(limit)
        @pagination = pagination(@notifications_paginated)
        @user = current_api_v1_user
      end
    end
  end
end
