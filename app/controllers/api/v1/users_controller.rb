module Api
  module V1
    class UsersController < ApplicationController
      def show
        @user = User.find(params[:id])
      end
    end
  end
end