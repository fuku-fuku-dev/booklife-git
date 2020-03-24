Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'toppages/iine', to: 'toppages#iine'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get "signup", to: "users#new"
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :likes
    end
  end
  
  resources :books, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :iines
    end
  end
  
  resources :favorites, only: [:create, :destroy]
end
