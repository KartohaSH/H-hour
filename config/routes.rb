Rails.application.routes.draw do
  namespace :admin do
    resources :products, except: [:show]
  end  

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"
  resources :products, only: :show

  root to: "main#index"
end
