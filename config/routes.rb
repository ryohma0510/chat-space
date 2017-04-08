Rails.application.routes.draw do
  devise_for :users
  root 'comments#index'
  resources :groups, only: [:new, :create, :show]
end
