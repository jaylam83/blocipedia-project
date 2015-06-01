Rails.application.routes.draw do
  #Welcome section
  get 'welcome/index'
  get 'welcome/about'

  #Home Page
  root to: 'welcome#index'

  
end
