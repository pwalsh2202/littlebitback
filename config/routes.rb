Rails.application.routes.draw do	
  root to: 'visitors#index'


  # user routes
  get '/u/:id' => 'users#show'
  resources :users
  

  # session routes
  get '/login' => 'users#login'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # campaign routes
  get '/c/index' => 'campaigns#index', as: :index_campaign
  get '/c/create' => 'campaigns#campaign_creation'
  post '/c/create' => 'campaigns#show'
  get '/c/:title' => 'campaigns#show'
  resources :campaigns
end
