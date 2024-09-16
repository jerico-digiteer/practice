Rails.application.routes.draw do
  get 'checkout/show'
  get 'checkout/create'
  get 'carts/show'
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

  resources :cart_items, only: [:create, :destroy, :show]
  resources :orders, only: [:new, :create, :show]
  resource :cart, only: [:show]
  resource :checkout, only: [:show, :create]


  resources :products, only: [:index, :show, :home]
  resource :wallet, only: [:show, :update]

  root 'home#index'
end
