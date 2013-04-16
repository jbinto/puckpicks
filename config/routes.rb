Puckpicks::Application.routes.draw do

  root :to => 'home#home'

  resources :users, only: ['create']
  get "register" => 'users#new', as: "register"

end
