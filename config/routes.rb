Rails.application.routes.draw do

  resource :session, only: %i(create destroy)
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :movies, only: %i(new create destroy) do
    resource :vote, only: %i(create destroy)
  end

  resources :users, only: %i() do
    resources :movies, only: %(index), controller: 'movies'
  end

  get '/settings', to: 'me#settings'
  post '/settings', to: 'me#update_settings'

  root 'movies#index'
end
