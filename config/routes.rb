  Rails.application.routes.draw do

  root 'users#index'

  resources :users, except: [:destroy] # каких экшенов не будет в контроллере!
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'

  # get 'show' => 'users#show'
end
