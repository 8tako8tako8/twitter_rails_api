# frozen_string_literal: true

module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        private

        def sign_up_params
          name = generate_unique_token(:name)
          nickname = generate_unique_token(:nickname)
          params.merge!(name:, nickname:)
          params.permit(:email, :password, :password_confirmation, :name, :nickname)
        end

        def generate_unique_token(attribute)
          loop do
            token = SecureRandom.hex(8)
            break token unless User.exists?(attribute => token)
          end
        end
      end
    end
  end
end
