Rails.application.routes.draw do
  get "orders/show"
  get "carts/show"

  namespace :admin do
    get "orders/index"
    resources :products, except: [:show]
    resources :orders, only: [:index, :show]
  end  

  resource :cart do
    post 'add_item', on: :collection
    post 'checkout', on: :collection
    delete 'remove_item/:id', to: 'carts#remove_item', as: :remove_item
  end

  resources :orders, only: [:show]

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  resources :products, only: [:show] do
    resources :reviews, only: [:create]  # Вкладений маршрут для створення відгуку
  end

  root to: "main#index"
end
