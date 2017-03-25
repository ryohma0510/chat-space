Rails.application.routes.draw do
  devise_for :users
  root 'comments#index'
end
