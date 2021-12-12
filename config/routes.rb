Rails.application.routes.draw do
  namespace :admin do
    get 'departments/new'
    get 'departments/edit'
    get 'departments/show'
    get 'departments/index'
  end
  namespace :admin do
    get 'pages/home'
    resources :works
    resources :departments
    
    resources :users do
      post :confirm, action: :confirm_new, on: :new
    end
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
  
  resources :users
  
  resources :works 
  get 'works/new/:fiscalyear', to: 'works#new_work'
  post 'works/new', to: 'works#new_work_create'
  
  resources :workflows
  
  resources :budgets
  resources :todos
  get 'todos/new/:id',  to: 'todos#new_todo'
  post 'todos/new',  to: 'todos#new_todo_create'
  post 'todos/move_index'
  get 'todos/index/:status',  to: 'todos#move_index'
 
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
