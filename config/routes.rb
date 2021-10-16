Rails.application.routes.draw do
  root 'sessions#new'
  get 'pages/home'
  get 'pages/test'
  
  resources :todos
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
