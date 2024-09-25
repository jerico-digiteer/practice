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
    resources :orders, only: [:index, :show]

    resources :reviews, only: [:index, :destroy] do
      member do
        post :hide
      end
    end
  end

  namespace :users do
    get 'dashboard', to: 'dashboard#index'
  end

  resources :cart_items, only: [:create, :destroy, :show]
  resources :orders, only: [:new, :create, :show]
  resource :cart, only: [:show]
  get 'checkout', to: 'checkouts#show'
  post 'checkout', to: 'checkouts#create'

  resources :products, only: [:index, :show, :home] do
    resources :reviews, only: [:new, :create, :index, :edit, :update, :destroy]
  end

  resource :wallet, only: [:show, :update]

  root 'home#index'
end
