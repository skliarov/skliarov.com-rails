Consigliere::Application.routes.draw do
  resources :static_pages

  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "signin", :sign_out => "signout" }

  root to: "articles#index"
  
  resources :articles

end