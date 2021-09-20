Rails.application.routes.draw do


  resources :categories
  get '/marketplace', to: 'products#index'
  get 'home/index'
  resources :posts, except:[:index]
  devise_for :users
  resources :users
  resources :in_shopping_carts, only: [:create, :destroy]
  resources :friendships, only: [:create, :index, :update]
  resources :has_categories, only: [:destroy]

  resources :products do
    member do
      delete :delete_image_attachment
    end
  end

  authenticated :user do
    root to: 'home#index'
  end

  unauthenticated :user do
    root to: 'home#unregistered', as: :unregistered
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
