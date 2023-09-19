module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_api_v1_user!, only: %i[show]

      def show
        @user = User.find(params[:id])
      end
    end
  end
end