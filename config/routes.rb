Rails.application.routes.draw do
  resources :users, :posts
  resources :sessions, only: [:new, :create, :destroy]
  root 'posts#index'

  match '/signup', to: 'users#new', via: 'get'
  match '/login', to: 'sessions#new', via: 'get'
  match '/logout', to: 'sessions#destroy', via: 'delete'
end
