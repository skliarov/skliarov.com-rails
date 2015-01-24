Consigliere::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :users, :path_names => { :sign_up => "register", :sign_in => "signin", :sign_out => "signout" }

  root to: "articles#index"

  resources :articles
  get "/feed", to: "articles#feed", defaults: { format: 'rss' }

  get "/about", to: "pages#about"
  get "/portfolio", to: "pages#portfolio"
  get "/contacts", to: "pages#contacts"
end