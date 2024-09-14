Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
  end

  namespace :users do
    get 'dashboard', to: 'dashboard#index'
  end

  # Regular routes for products (accessible by all users)
  resources :products, only: [:index, :show]

  # Root path (you can adjust this to your preferred path)
  root 'products#index'
end
