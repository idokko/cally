Rails.application.routes.draw do
  get 'works/new'
  get 'sessions/new'
  get 'users/new'
  get 'pages/index'
  get 'lists/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
  
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  
  resources :users
  resources :works
end
