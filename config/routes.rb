# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'users', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions'
      }
      get :user_session, to: 'users#user_session', format: 'json'

      resources :users, only: %i[show], format: 'json' do
        post :follow, to: 'follows#create'
        post :unfollow, to: 'follows#destroy'
      end
      resource :profile, only: %i[update], controller: 'users', format: 'json' do
        put :avatar_image, controller: 'images', action: 'update_avatar_image', format: 'json'
        put :header_image, controller: 'images', action: 'update_header_image', format: 'json'
      end
      resources :tweets, only: %i[index create destroy], format: 'json'
      resources :tweets, only: [:show], format: 'json' do
        resources :comments, only: [:index]
        resource :retweet, only: %i[create destroy]
        resource :favorite, only: %i[create destroy]
      end
      resources :images, only: [:create], format: 'json'
      resources :comments, only: %i[create destroy], format: 'json'
      resources :notifications, only: [:index], format: 'json'
      resources :groups, only: %i[index create], format: 'json' do
        resources :messages, only: %i[index create], format: 'json'
      end
      resources :bookmarks, only: %i[index create], format: 'json'
      delete :bookmarks, to: 'bookmarks#destroy', format: 'json'

      get :health_check, to: 'health_check#index'
    end
  end
end
