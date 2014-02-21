Beam::Application.routes.draw do
  resources :searches, only:[:create,:index]
  resources :sessions, only:[:index]
  root 'searches#index'
  get 'session/:action', :to => 'sessions'
end
