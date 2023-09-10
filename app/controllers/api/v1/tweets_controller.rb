# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include Pagination

      def index
        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        tweets = Tweet.order(created_at: :desc, id: :desc)

        @tweets_paginated = tweets.page(offset).per(limit)
        @pagination = pagination(@tweets_paginated)
      end
    end
  end
end
