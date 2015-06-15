Rails.application.routes.draw do

  devise_for :users
  #Welcome section
  get 'welcome/index'
  get 'welcome/about'

  #wikis
  resources :wikis

  #Home Page
  root to: 'welcome#index'

  
end
