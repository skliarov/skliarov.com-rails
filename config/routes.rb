Consigliere::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  root to: "articles#index"
  
  resources :articles

end