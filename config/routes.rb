Rails.application.routes.draw do

  resources :questions do
    resources :comments
    resources :answers 
  end
  
  get 'users/locked'
  resources :users
  
  get 'search/results'
  resources :search

  get 'home/help'
  get 'home/about'
  get 'home/contact'
  resources :home

  root 'home#index'
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
end
