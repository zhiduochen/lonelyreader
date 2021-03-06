Rails.application.routes.draw do

  root 'welcome#index'
  # devise_for :users
  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks"}

  namespace :admin do
    resources :products
    resources :categories
    resources :orders do
      member do
        post :cancel
        post :ship
        post :shipped
        post :return
      end
    end
  end

  resources :products do
    member do
      post :add_to_cart
      post :collect
      post :discollect
    end
  end

  resources :carts do
    collection do
      delete :clean
      post :checkout
    end
  end

  resources :cart_items do
    member do
      post :add
      post :minus
    end
  end


  resources :orders do
    member do
      post :pay_with_alipay
      post :pay_with_wechat
      post :apply_to_cancel
    end
  end

  namespace :account do
    resources :orders
    resources :users
    resources :favorites do
      member do
        post :remove
      end
    end
  end

  resources :boards do
    member do
      post :join
      post :quit
    end
    resources :posts do
      resources :comments
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
