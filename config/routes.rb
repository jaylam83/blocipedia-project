Rails.application.routes.draw do
  get 'users/update'

  devise_for :users
  resources :users, only: [:update]
  post 'users/downgrade'
  #Welcome section
  get 'welcome/index'
  get 'welcome/about'

  #wikis
  resources :wikis

  #Home Page
  root to: 'welcome#index'

  #Stripe charges
  resources :charges, only: [:new, :create]
  
end
