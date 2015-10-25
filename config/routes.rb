Rails.application.routes.draw do
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords',
      confirmations: 'users/confirmations',
      omniauth_callbacks: 'users/omniauth_callbacks',
      unlocks: 'users/unlocks'
    }


  root 'welcome#index'
  get '/current', to: 'welcome#current'
  get '/pending', to: 'welcome#pending'

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    member do
      put 'accept'
    end
  end
  resources :projects
  resources :memberships, only: [:edit, :update, :destroy]
  resources :periods do
    member do
      put 'add_member'
    end
  end

  resources :records, only: [:index, :create]
end
