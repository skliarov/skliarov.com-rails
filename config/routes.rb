Rails.application.routes.draw do
  # Root path
  root to: 'public#main'
  
  # # CKEditor routes integration
  # mount Ckeditor::Engine => '/ckeditor'
  #
  # # Authentication router
  # devise_for :users, path_names: {
  #   sign_up: 'register',
  #   sign_in: 'sign-in',
  #   sign_out: 'sign-out'
  # }, skip: :registrations
  #
  # # Articles
  # resources :articles, param: :slug, only: [:index, :show]
  #
  # # RSS feed
  # get '/feed', to: 'articles#feed', defaults: { format: 'rss' }
  #
  # # Admin panel
  # namespace :admin do
  #   resources :articles, param: :slug do
  #     post :publish, on: :member
  #     post :hide, on: :member
  #     post :sort, on: :collection
  #   end
  # end
  #
  # match '/admin', to: redirect('/admin/articles'), via: :get
  #
  # # Static pages
  # get '/', to: 'pages#about'
end
