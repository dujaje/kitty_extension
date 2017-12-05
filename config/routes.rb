Rails.application.routes.draw do
  # PAGES CONTROLLER
  root :to => "pages#home"
  get 'components', to: 'pages#components'

  get 'welcome', to: 'pages#redirect'
  get 'create_kitty', to: 'pages#create_kitty'
  get 'info', to: 'pages#info'

  # OTHER ROOT CONTROLLERS
  resources :groups, only: [:show, :update]
  resources :expenses, only: [:new, :create, :show]
  get 'settle', to: 'expenses#settle'
  resources :users, only: [:show]

# WEBHOOKS FOLDER, WEBHOOKS CONTROLLER
  namespace :webhooks do
    get 'webhooks', to: 'webhooks#messenger'
    post 'webhooks', to: 'webhooks#messenger_receive_message'
  end

# API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [ :create ]
    end
  end
end
