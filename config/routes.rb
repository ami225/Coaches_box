Rails.application.routes.draw do
  namespace :coaches do
    get 'categories/index'
    get 'categories/edit'
  end
  
   #Coach側ルーティング
  namespace :coaches do
    root to: 'homes#top'
    # TODO: coarchs/coarchs みたいになってるので後で消す
    get   'coaches/my_page' => 'coaches#show'
    get   'coaches/edit'    => 'coaches#edit'
    patch 'coaches'         => 'coaches#update'
    resources :posts,       only: [:new, :create, :edit, :update, :index, :show, :destroy] 
    get 'chat/:id' => 'coaches#chat' 
  end
   devise_for :coaches, controllers: {
    sessions:  'coaches/sessions',
    passwords: 'coaches/passwords',
    registrations: 'coaches/registrations'
  }
  
  #User側ルーティング
  scope module: :users do
    root to: 'homes#top'
    get   'users/my_page' => 'users#show'
    get   'users/edit'    => 'users#edit'
    patch 'users'         => 'users#update'
    resources :coaches,   only: [:show]
    resources :posts,     only: [:index, :show] do
     resource :favorites, only: [:create, :destroy]
    end

  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  
 
  #DM機能ルーティング（コーチ側ユーザー側共通）
  resources :messages, only: [:create] 
  resources :rooms,    only: [:create,:show]
  
 

end
