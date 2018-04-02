Rails.application.routes.draw do
  # root to: 'tasks#index'
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  # resources :users, only: [:show, :create]
  resources :users, only: [:create]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :tasks
end