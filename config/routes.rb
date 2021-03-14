Rails.application.routes.draw do
  get "books/search", to: "books#search", as: "book_search"
  # get "authors/search", to: "authors#search", as: "author_search"

  resources :authors
  resources :books
  resources :categories
  resources :publishers

  devise_for :users
  
  get "/profile", to: "users#profile", as: "user_profile"
  get "/profile/edit", to: "users#edit", as: "edit_user"
  patch "/profile/edit", to: "users#update"
  
  get "categories/1", to: "categories#show", as: "creative_arts"
  get "categories/2", to: "categories#show", as: "design"
  get "categories/3", to: "categories#show", as: "tech"
  get "categories/4", to: "categories#show", as: "science"
  
  get "/payments/success", to: "payments#success"
  post "/payments/webhook", to: "payments#webhook"

  root to: "home#index"
end
