Rails.application.routes.draw do
  get 'works/new'
  get 'sessions/new'
  get 'users/new'
  get 'pages/index'
  get 'lists/index'
  get 'users/show'
  get 'rooms/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  post 'logout', to: 'sessions#destroy', as: :logout
  
  resources :users
  resources :works do
    get 'works', to: 'works#search'
  end
  
  namespace :admin do
    resources :users, only: [:index]
  end
end
