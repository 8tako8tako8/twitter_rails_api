# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        def index
          render json: current_api_v1_user
        end
      end
    end
  end
end
