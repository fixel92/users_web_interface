Rails.application.routes.draw do
  root 'users#index'
  devise_for :users, skip: %i[registrations passwords]
  resources :users
end
