Rails.application.routes.draw do

  # Coach側ルーティング
  namespace :coaches do
    resources :coaches, only: [:show, :edit, :index, :update] do
      resource :favorites, only: [:create, :destroy]
    end
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
    resources :coaches, only: [:show, :index]
    resources :posts, only: [:index, :show]
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  # コーチ側ユーザー側共通ルーティング

  resources :messages, only: [:create]
  resources :rooms,    only: [:create, :show, :index]
  get 'finder' => "finders#finder"
  resources :favorite_coaches, only: [:index] 
end
