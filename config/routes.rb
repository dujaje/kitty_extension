Rails.application.routes.draw do
  # PAGES CONTROLLER
  root :to => "pages#home"
  get 'components', to: 'pages#components'

  get 'welcome', to: 'pages#redirect'
  get 'create_kitty', to: 'pages#create_kitty'
  get 'info', to: 'pages#info'

  # GROUPS CONTROLLERS
  resources :groups, only: [:show, :update]
  get '/reminder', to: 'groups#reminder', as: 'groups_reminder'

  # EXPENSES CONTROLLERS
  resources :expenses, only: [:new, :create, :show]
  get 'settle', to: 'expenses#settle'

  # USERS CONTROLLERS
  resources :users, only: [:show]
  get '/transactions/:id', to: 'users#transactions', as: 'user_transactions'

# WEBHOOKS FOLDER, WEBHOOKS CONTROLLER
  get 'webhooks', to: 'webhooks#messenger'
  post 'webhooks', to: 'webhooks#messenger_receive_message'

# API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [ :create ]
    end
  end
end
