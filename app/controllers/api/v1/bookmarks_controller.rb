module Api
  module V1
    class BookmarksController < ApplicationController
      def index
        offset = params[:offset].presence || 1
        limit = params[:limit].presence || 10
        # TODO: ページネーションのために全件検索しているが、パフォーマンス改善のため、全件検索しないようにする
        all_bookmarks = current_api_v1_user.bookmarks.order(created_at: :desc, id: :desc)

        @bookmarks_paginated = all_bookmarks.page(offset).per(limit)
        @pagination = pagination(@bookmarks_paginated)
      end
  end
end
