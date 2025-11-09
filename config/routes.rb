Rails.application.routes.draw do
  root "products#index"
  resources :products
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
