Rails.application.routes.draw do
  namespace :coaches do
    get 'categories/index'
    get 'categories/edit'
  end
  namespace :user do
    get 'rooms/show'
  end
  get 'messages/create'
  get 'rooms/create'
  get 'rooms/show'
  #User側ルーティング
  scope module: :users do
    root to: 'homes#top'
    get   'users/my_page' => 'users#show'
    get   'users/edit'    => 'users#edit'
    patch 'users'         => 'users#update'
    resources :posts, only: [:index, :show] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show]
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  
  #Coach側ルーティング
  namespace :coaches do
    root to: 'homes#top'
    get   'coaches/my_page' => 'coaches#show'
    get   'coaches/edit'    => 'coaches#edit'
    patch 'coaches'         => 'coaches#update'
    resources :posts, only: [:new, :create, :edit, :update, :index, :show, :destroy] 
    
    resources :messages, only: [:create] #DM機能
    resources :rooms, only: [:create,:show]#DM機能
    
  end
  devise_for :coaches, controllers: {
    sessions:  'coaches/sessions',
    passwords: 'coaches/passwords',
    registrations: 'coaches/registrations'
  }

end
