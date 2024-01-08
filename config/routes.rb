Rails.application.routes.draw do
  resources :watchlists
  resources :payement_details
  resources :play_times
  resources :help_desks
  resources :profiles
  resources :histories
  resources :reminders
  resources :coupons
  resources :subscriptions
  resources :subscription_histories
  resources :episodes
  resources :contents
  resources :users
  resources :appopens
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/logout' => 'welcome#logout'
  get '/search-user' => 'users#index'
  get '/dashboard' => 'welcome#index'  
  get '/invite/:referral_code' => 'welcome#invite'
  match '/login' => 'welcome#login', :via => [:get, :post]
  
  root "welcome#invite"

  mount MovieApp::Base => '/'

end
