Consigliere::Application.routes.draw do
  # CKEditor routes integration
  mount Ckeditor::Engine => '/ckeditor'
  
  # Authentication router
  devise_for :users, path_names: {
    sign_up: 'register',
    sign_in: 'signin',
    sign_out: 'signout'
  }
  
  # Root path
  root to: 'articles#index'
  
  # Articles
  resources :articles, only: [:index, :show, :edit, :update]
  
  # Screencasts and Lessons
  resources :screencasts, only: [:index, :show] do
    resources :lessons, only: [:show]
  end
  
  # Admin panel
  namespace :admin do
    resources :chapters
    resources :screencasts do
      resources :lessons
    end
  end
  
  # RSS feed
  get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  
  # Static pages
  get '/about', to: 'pages#about'
  get '/portfolio', to: 'pages#portfolio'
  get '/contacts', to: 'pages#contacts'
end