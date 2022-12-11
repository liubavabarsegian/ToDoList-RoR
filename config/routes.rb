Rails.application.routes.draw do 
  get 'calendars/show'
  resources :tasks
  resource :session, only: %i[new create destroy]
  resources :sessions, only: %i[new create show]
  resources :users

  root 'tasks#index'
  get 'login', to: 'sessions#new'
  get 'new', to: 'users#new'
  get '/users/:user_id', to: 'users#show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end