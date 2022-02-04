Rails.application.routes.draw do
  namespace :admin do
    get 'pages/home'
    get 'users/search',  to: 'users#search'
    get 'departments/search',  to: 'departments#search'
    resources :works
    
    resources :departments do
      post :confirm, action: :confirm_new, on: :new
    end
    
    resources :users do
      post :confirm, action: :confirm_new, on: :new
    end
  end
  
  root 'sessions#new'
  get 'pages/home'
  get 'pages/test'
  
  post 'works/switch_show'
  post 'works/switch_index'
  get 'works/index/:id',  to: 'works#switch_index'
  get 'works/none'
  get 'works/copy'
  post 'works/copied'
  post 'works/add_flow'
  post 'works/remove_flow'
  
  resources :users
  
  resources :works 
  get 'works/new/:fiscalyear', to: 'works#new_work'
  post 'works/new', to: 'works#new_work_create'
  
  resources :workflows
  
  resources :budgets
  
  resources :todos
  get 'todos/new/:id',  to: 'todos#new_from_work_show_page'
  post 'todos/new',  to: 'todos#create_from_work_show_page'
  post 'todos/switch_index'
  get 'todos/index/:status',  to: 'todos#switch_index'
  
  resources :events
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
