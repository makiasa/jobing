Rails.application.routes.draw do
  namespace :admin do
    get 'pages/home'
    get 'works/copy'
    post 'works/copied'
    resources :users
    resources :works
  end
  
  root 'sessions#new'
  get 'pages/home'
  get 'pages/test'
  
  post 'works/move_show'
  post 'works/move_index'
  get 'works/index/:id',  to: 'works#move_index'
  get 'works/none'
  get 'works/copy'
  post 'works/copied'
  post 'works/add_flow'
  post 'works/remove_flow'
  
  resources :works 
  resources :workflows
  
  resources :budgets
  resources :todos
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
