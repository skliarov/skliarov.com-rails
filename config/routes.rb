AppDevAcademy::Application.routes.draw do
  # Root path
  root to: 'pages#home'
  
  # CKEditor routes integration
  mount Ckeditor::Engine => '/ckeditor'
  
  # Authentication router
  devise_for :users, path_names: {
    sign_up: 'register',
    sign_in: 'sign-in',
    sign_out: 'sign-out'
  }, skip: :registrations
  
  # Articles
  resources :articles, only: [:index, :show]
  
  # RSS feed
  get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  
  # Admin panel
  namespace :admin do
    resources :articles do
      post :publish, on: :member
      post :hide, on: :member
      post :sort, on: :collection
    end
  end
  
  # Static pages
  get '/about', to: 'pages#about'
  get '/contacts', to: 'pages#contacts'
end