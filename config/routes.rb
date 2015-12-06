AppDevAcademy::Application.routes.draw do
  # CKEditor routes integration
  mount Ckeditor::Engine => '/ckeditor'
  
  # Authentication router
  devise_for :users, path_names: {
    sign_up: 'register',
    sign_in: 'sign-in',
    sign_out: 'sign-out'
  }, skip: :registrations
  
  # Root path
  root to: 'articles#index'
  
  # Articles
  resources :articles, only: [:index, :show]
  
  # Screencasts and Lessons
  resources :screencasts, only: [:index, :show] do
    resources :lessons, only: [:show]
  end
  
  # Admin panel
  namespace :admin do
    resources :articles do
      post :publish, on: :member
      post :sort, on: :collection
    end
    resources :chapters do
      post :sort, on: :collection
    end
    resources :screencasts do
      post :sort, on: :collection
    end
    resources :lessons do
      post :sort, on: :collection
    end
  end
  get '/admin', to: redirect('/admin/articles')
  
  # RSS feed
  get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  
  # Static pages
  get '/about', to: 'pages#about'
  get '/portfolio', to: 'pages#portfolio'
  get '/contacts', to: 'pages#contacts'
end