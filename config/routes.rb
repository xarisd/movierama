Rails.application.routes.draw do
  
  resource :session, only: %i(create destroy)
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :movies, only: %i(new create destroy) do
    resource :vote, only: %i(create destroy)
  end
  root 'movies#index'
end
