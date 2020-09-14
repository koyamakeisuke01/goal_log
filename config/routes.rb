Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "tweets#index"
  resources :tweets do
    resources :comments, only: :create
  end
  resources :comments
  resources :users
  resources :tasks do
    member do
    # collection do
      get :todo, :done, :check
    end
  end
end
