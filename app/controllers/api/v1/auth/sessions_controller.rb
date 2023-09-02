# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        def index
          if current_api_v1_user
            render json: { login_user: true, data: current_api_v1_user }
          else
            render json: { login_user: false, message: 'ユーザーが存在しません' }
          end
        end
      end
    end
  end
end
