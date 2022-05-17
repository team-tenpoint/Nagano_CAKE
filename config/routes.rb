Rails.application.routes.draw do
 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  root to: "orders#index"
  resources :genres, only: [:index, :create, :edit, :update]
  resources :items, except: [:destroy]
end

root to: "public/items#top"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
