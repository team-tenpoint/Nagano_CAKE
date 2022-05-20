Rails.application.routes.draw do

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  root to: "orders#index"
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, except: [:destroy]
  resources :customers, only: [:index, :show, :edit, :update]

end

root to: "public/items#top"
get "about" => "public/items#about"
delete "cart_items" => "public/cart_items#all_destroy"

scope module: :public do
  resources :cart_items
  resources :items
  get '/customers/quit' => 'customers#quit', as: 'quit'
  resources :customers, only: [:show, :edit, :update]
  resources :addresses, except: [:new, :show]
end


# scope module: :public do
# get '/customers/quit' => 'customers#quit', as: 'quit'
# resources :customers, only: [:show, :edit, :update]
# end

scope module: :public do
  get '/orders/new' => 'orders#new',as: 'new'
  post '/orders/confirm' => 'orders#confirm', as: 'confirm'
  get '/orders/complete' => 'orders#complete', as: 'complete'
  resources :orders,only:[:create, :index, :show]
end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
