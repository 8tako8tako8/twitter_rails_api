# frozen_string_literal: true

module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        before_action :reject_user, only: [:create]

        private
      
        def reject_user
          user = User.find_by(email: params[:email]&.downcase)
          render json: { errors: 'アカウントが無効です。' }, status: :unprocessable_entity if user&.deleted_at.present?
        end
      end
    end
  end
end
