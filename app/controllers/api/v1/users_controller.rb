# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Pagination
      before_action :authenticate_api_v1_user!, only: %i[show]

      def show
        @user = User.find(params[:id])

        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        # TODO: ページネーションのために全件検索しているが、パフォーマンス改善のため、全件検索しないようにする
        all_tweets = @user.tweets.with_attached_image.order(created_at: :desc, id: :desc)

        @tweets_paginated = all_tweets.page(offset).per(limit)
        @pagination = pagination(@tweets_paginated)
      end
    end
  end
end
