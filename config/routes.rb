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
  
  # RSS feed
  get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  
  # Screencasts and Lessons
  resources :screencasts, only: [:index, :show] do
    resources :lessons, only: [:show]
  end
  
  # Admin panel
  namespace :admin do
    resources :articles do
      post :sort, on: :collection
      post :publish, on: :member
    end
    resources :chapters do
      resource :screencasts, only: [:new]
      post :sort, on: :collection
      post :publish, on: :member
      post :hide, on: :member
    end
    resources :screencasts, except: [:index, :new] do
      resource :lessons, only: [:new]
      post :sort, on: :collection
      post :publish, on: :member
      post :hide, on: :member
    end
    resources :lessons, except: [:index] do
      post :sort, on: :collection
      post :publish, on: :member
      post :hide, on: :member
    end
  end
  
  # Static pages
  get '/about', to: 'pages#about'
  get '/portfolio', to: 'pages#portfolio'
  get '/contacts', to: 'pages#contacts'
end