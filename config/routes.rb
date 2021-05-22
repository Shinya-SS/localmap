Rails.application.routes.draw do
  get 'mypages/index'
  get 'sessions/new'

  root 'pages#index'

  resources :users do
    collection do 
      get 'users/auto_complete'
    end
  end
  
  resources :topics
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

end