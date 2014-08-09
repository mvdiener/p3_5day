Rails.application.routes.draw do
  resources :users
  resources :flights, only: [:create, :show]
  resources :airlines, only: [:show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :posts, only: [:index, :create, :destroy]

  root 'posts#index'

  match '/signup', to: 'users#new', via: 'get'
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'

end
