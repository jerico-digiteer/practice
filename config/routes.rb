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

  resources :products, only: [:index, :show, :home]

  root 'home#index'
end
