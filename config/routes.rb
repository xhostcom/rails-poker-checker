require 'sidekiq/web'

Rails.application.routes.draw do
  resources :hands
  resources :checks
  root to: 'checks#index'
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
 authenticate :user, lambda { |u| u.admin? } do
   mount Sidekiq::Web => '/sidekiq'
end

  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
end
