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

  get 'month', to: 'calendars#month'
  get 'week', to: 'calendars#week'

  post '/complete', to: 'tasks#complete'
  post '/uncomplete', to: 'tasks#uncomplete'
  post '/choose', to: 'tasks#choose'
  
  resources :users do
    member do
      get :confirm_email
    end
  end

end
