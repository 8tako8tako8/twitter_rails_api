# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: [:index]
      end

      resources :users, only: %i[show], format: 'json'
      resource :profile, only: %i[update], controller: 'users', format: 'json' do
        put :avatar_image, controller: 'images', action: 'update_avatar_image', format: 'json'
        put :header_image, controller: 'images', action: 'update_header_image', format: 'json'
      end
      resources :tweets, only: %i[index create destroy], format: 'json'
      resources :tweets, only: [:show], format: 'json' do
        resources :comments, only: [:index]
      end
      resources :images, only: [:create], format: 'json'
      resources :comments, only: %i[create destroy], format: 'json'
    end
  end
end
