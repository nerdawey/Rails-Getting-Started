Rails.application.routes.draw do
  root "products#index"
  resources :products do
    post "subscribers", to: "subscribers#create", as: :subscribe
    delete "subscribers", to: "subscribers#destroy", as: :unsubscribe
  end
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
end
