Rails.application.routes.draw do
  resources :products
  devise_for :admins
  devise_for :users


  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
  end
  
  namespace :users do
    get 'dashboard', to: 'dashboard#index'
  end
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
