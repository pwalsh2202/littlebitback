Rails.application.routes.draw do
  resources :users
  root to: 'visitors#index'

  # session routes
  get '/login' => 'users#login'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # campaign routes
  get '/campaign/create' => 'campaigns#campaign_creation'
  post '/campaign/create' => 'campaigns#creation_callback'

end
