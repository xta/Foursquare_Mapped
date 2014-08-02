FoursquareMapped::Application.routes.draw do
  devise_for :users,
              controllers: {omniauth_callbacks: "omniauth_callbacks"}

  root 'pages#index'

  get :sync_checkins, to: 'pages#sync_checkins', as: 'sync_checkins'

  get :load_all_checkins, to: 'pages#load_all_checkins', as: 'load_all_checkins'
  get 'show/:id', to: 'pages#show', as: 'show'
  get 'privacy', to: 'pages#privacy', as: 'privacy'
end
