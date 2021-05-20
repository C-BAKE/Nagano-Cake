Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :admin
  
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    get 'end_users/:end_user_id/orders' => 'orders#index', as: 'end_user_orders'
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end

  devise_for :end_users, controllers: {
    sessions: 'end_users/sessions',
    registrations: 'end_users/registrations',
  }
  
  scope module: :public do
    root 'homes#top'
    get 'homes/about' => 'homes#about'
    get 'end_users/mypage' => 'end_users#show', as: 'mypage'
    get 'end_users/edit' => 'end_users#edit', as: 'edit'
    patch 'end_users' => 'end_users#update', as: 'update'
    get 'end_users/unsubscribe' => 'end_users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw_end_user'
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'destroy_all_cart_items'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete', as: 'complete'

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:new, :index, :create, :show]
  end
end
