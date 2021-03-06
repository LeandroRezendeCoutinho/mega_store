Rails.application.routes.draw do
  resources :stores, only: [:index] do
    resources :products, only: [:index]
  end

  resources :products, only: [:show] do
    resources :purchases, only: [:create]
  end

  resources :shippings, only: [:update, :show]
end
