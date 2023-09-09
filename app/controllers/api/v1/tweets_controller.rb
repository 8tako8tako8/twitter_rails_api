# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      include Pagination

      def index
        page = params[:page].presence || 1
        per = params[:per].presence || 10
        tweets = Tweet.order(created_at: :desc, id: :desc)

        @tweets_paginated = tweets.page(page).per(per)
        @pagination = pagination(@tweets_paginated)
      end
    end
  end
end
