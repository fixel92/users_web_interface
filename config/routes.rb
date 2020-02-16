Rails.application.routes.draw do
  root 'users#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show update]
      devise_scope :user do
        post 'users/sign_in', to: 'sessions#create', defaults: { format: :json }
        delete 'users/sign_out', to: 'sessions#destroy', defaults: { format: :json }
        post 'users/sign_up', to: 'registrations#create', defaults: { format: :json }
      end
    end
  end

  devise_for :users, skip: %i[registrations passwords]
  resources :users
end
