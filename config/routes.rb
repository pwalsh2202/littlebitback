Rails.application.routes.draw do
  # user routes
  get '/u/:id' => 'users#show'
  resources :users
  root to: 'visitors#index'

  # session routes
  get '/login' => 'users#login'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # campaign routes
  get '/c/create' => 'campaigns#campaign_creation'
  post '/c/create' => 'campaigns#show'
  get '/c/:title' => 'campaigns#show'
  resources :campaigns
end
