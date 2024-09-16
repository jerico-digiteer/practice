Rails.application.routes.draw do
  get 'home/index'
  devise_for :admins
  devise_for :users

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :products
  end

  namespace :users do
    get 'dashboard', to: 'dashboard#index'
  end

  resources :cart_items, only: [:create, :destroy]
  get 'cart', to: 'cart_items#index'


  resources :products, only: [:index, :show, :home]
  resource :wallet, only: [:show, :update]

  root 'home#index'
end
