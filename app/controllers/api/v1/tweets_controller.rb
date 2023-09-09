# frozen_string_literal: true

module Api
  module V1
    class TweetsController < ApplicationController
      def index
        @tweets = Tweet.all
      end
    end
  end
end
