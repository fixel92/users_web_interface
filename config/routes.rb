Rails.application.routes.draw do
  root 'users#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show update create]
    end
  end

  devise_for :users, skip: %i[registrations passwords]
  resources :users
end
