Rails.application.routes.draw do
  root 'users#index'
  resources :users
  devise_for :users
end
