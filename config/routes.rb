Rails.application.routes.draw do
  namespace :admin do
    get 'pages/home'
    resources :users
    resources :works
  end
  
  root 'sessions#new'
  get 'pages/home'
  get 'pages/test'
  
  post 'works/move'
  get 'works/none'
  
  resources :works 
  resources :workflows
  
  
  resources :budgets
  resources :todos
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
