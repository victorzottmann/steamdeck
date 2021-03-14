Rails.application.routes.draw do

  resources :books
  resources :categories
  resources :publishers
  resources :authors
  get 'home/index'
  devise_for :users
  root to: "home#index"
end
