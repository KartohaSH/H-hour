Rails.application.routes.draw do
  get "carts/show"
  namespace :admin do
    resources :products, except: [:show]
  end  

  resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: :add_item
    delete 'remove_item/:product_id', to: 'carts#remove_item', as: :remove_item
  end
  

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"
  resources :products, only: :show

  root to: "main#index"
end
