# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks
  resource :session, only: %i[new create destroy]
  resources :sessions, only: %i[new create show]
  resources :users

  root 'tasks#index'

  get 'login', to: 'sessions#new'
  get 'new', to: 'users#new'
  get '/users/:user_id', to: 'users#show'
  post 'choose_color', to: 'users#choose_color'
  get 'sounds', to: 'users#sounds'
  get 'save_sounds', to: 'users#save_sounds'

  get 'month', to: 'calendars#month'
  get 'week', to: 'calendars#week'

  post '/complete', to: 'tasks#complete'
  post '/uncomplete', to: 'tasks#uncomplete'
  post '/choose', to: 'tasks#choose'

  post 'send_request', to: 'friends#send_request'
  post 'cancell_request', to: 'friends#cancell_request'
  post 'accept_request', to: 'friends#accept_request'
  post 'decline_request', to: 'friends#decline_request'
  post 'destroy_friendship', to: 'friends#destroy_friendship'
  get 'friends', to: 'friends#index'

  get 'friends_competitions', to: 'competitions#friends'
  get 'all_competitions', to: 'competitions#all_users'

  resources :users do
    member do
      get :confirm_email
    end
  end
end
