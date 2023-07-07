Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  root 'users#index'

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
    delete 'logout', to: 'devise/sessions#destroy'
  end

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show destroy] do
      resources :comments, only: %i[new create destroy]
      resources :likes, only: [:create]
    end
  end

  # for api end point
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end
end
