Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  get 'works/new'
  get 'sessions/new'
  get 'users/new'
  get 'pages/index'
  get 'lists/index'
  get 'rooms/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'pages#index'
  
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout
  
  resources :users
  resources :rooms do
      member do
        get "buy"
        post "pay"
    end
  end
  resources :messages
  resources :works do
    get 'works', to: 'works#search'
  end
  resources :password_resets, only: %i[new create edit update]
  
  namespace :admin do
    resources :users, only: [:index]
  end
  
  resources :cards, only: [:new, :create, :show, :destroy]
  resources :costs, only: %i[new create]
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
