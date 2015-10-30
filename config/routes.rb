Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations',
      omniauth_callbacks: 'users/omniauth_callbacks',
      unlocks: 'users/unlocks'
    }

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index]

    resources :records, only: [] do
      collection do
        get :latest_ts
      end
    end
  end

  root 'welcome#index'
  get '/current', to: 'welcome#current'
  get '/pending', to: 'welcome#pending'

  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :projects
  resources :memberships, only: [:edit, :update, :destroy]
  resources :periods do
    member do
      put 'add_member'
    end
  end

  resources :records, only: [:index, :create, :update] do
    member do
      put 'leave'
    end
  end

end
