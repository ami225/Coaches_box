Rails.application.routes.draw do
  namespace :coaches do
    resources :coaches, only: [:show, :edit, :index, :update] do
      resource :favorites, only: [:create, :destroy]
      get 'favorites/favorites' => 'favorites#index'
    end
  end

  # Coach側ルーティング
  namespace :coaches do
    root to: 'homes#top'
    resources :posts, only: [:new, :create, :edit, :update, :index, :show, :destroy]
  end
  devise_for :coaches, controllers: {
    sessions: 'coaches/sessions',
    passwords: 'coaches/passwords',
    registrations: 'coaches/registrations',
  }

  # User側ルーティング
  scope module: :users do
    root to: 'homes#top'
    get   'users/my_page' => 'users#show'
    resources :users, only: [:edit, :update] 
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  # DM機能ルーティング（コーチ側ユーザー側共通）

  resources :messages, only: [:create]
  resources :rooms,    only: [:create, :show, :index]
  get 'finder' => "finders#finder"
end
