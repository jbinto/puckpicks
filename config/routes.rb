Puckpicks::Application.routes.draw do

  root :to => 'home#home'

  resources :users, only: ['create']
  resource :sessions, only: ['create', 'destroy']

  get "register" => 'users#new', as: "register"
  get "login" => 'sessions#new', as: "login"

  namespace :my do
    resources :picks, only: ['create', 'index']
  end

end
