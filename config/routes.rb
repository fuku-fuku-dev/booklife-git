Rails.application.routes.draw do
  root to: 'toppages#index'
  get 'toppages/iine', to: 'toppages#iine'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get "signup", to: "users#new"
  
  resources :users, only: [:index, :show, :new, :create, :update] do
    member do
      get :likes
      post :image
    end
  end
  
  resources :books, only: [:index, :show, :new, :create, :destroy, :update] do
    resources :comments, only: [:create, :destroy]
    member do
      get :new_books
      get :old_books
      get :many_favorites
      get :my_favorites
      post :image
    end
  end
  
  resources :favorites, only: [:create, :destroy]
end
