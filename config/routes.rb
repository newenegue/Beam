Beam::Application.routes.draw do
  resources :albums
  resources :searches, only:[:create,:index]
  resources :sessions, only:[:index]
  resources :users, only: [:show]
  root 'searches#index'
  get 'session/:action', :to => 'sessions'
  post 'albums/add_image', :to => 'albums#add_image'
  post 'albums/remove_image', :to => 'albums#remove_image'
end
