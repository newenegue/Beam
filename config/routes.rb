Beam::Application.routes.draw do
  resources :albums
  resources :searches, only:[:create,:index]
  resources :sessions, only:[:index]
  resources :users, only: [:create]
  root 'searches#index'
  get 'session/:action', :to => 'sessions'
end
