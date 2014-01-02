Consigliere::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "signin", :sign_out => "signout" }

  root to: "articles#index"

  get '/tutorials', :controller => 'static_pages', :action => 'show', :id => 1
  get '/about', :controller => 'static_pages', :action => 'show', :id => 2
  get '/contacts', :controller => 'static_pages', :action => 'show', :id => 3
  resources :static_pages, :only => [:show, :edit, :update]

  resources :articles

end