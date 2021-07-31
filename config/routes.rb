Rails.application.routes.draw do


  resources :products
  get '/marketplace', to: 'products#index'
  get 'home/index'
  resources :posts, except:[:index]
  devise_for :users
  resources :users
  resources :friendships, only: [:create, :index, :update]

  authenticated :user do
    root to: 'home#index'
  end

  unauthenticated :user do
    root to: 'home#unregistered', as: :unregistered
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
