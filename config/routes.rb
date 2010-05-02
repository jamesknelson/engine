Locomotive::Application.routes.draw do |map|
  
  constraints(Locomotive::Routing::DefaultConstraint) do
    root :to => 'home#show'
  end
  
  # admin authentication
  Devise.register(:accounts, :controllers => { :sessions => 'admin/sessions', :passwords => 'admin/passwords' }) # bypass the devise_for :accounts  
  scope '/admin' do
    get 'login' => 'admin/sessions#new', :as => :new_account_session
    post 'login' => 'admin/sessions#create', :as => :account_session
    get 'logout' => 'admin/sessions#destroy', :as => :destroy_account_session    
    resource :password, :only => [:new, :create, :edit, :update], :controller => 'admin/passwords'
  end
  
  # admin interface for each website
  namespace 'admin' do
    root :to => 'pages#index'
    
    resources :pages do  
      put :sort, :on => :member
      get :get_path, :on => :collection 
    end 
    
    resources :layouts
    resources :snippets
    
    # get 'login' => 'sessions#new', :as => :new_account_session
    # post 'login' => 'sessions#create', :as => :account_session
    # get 'logout' => 'sessions#destroy', :as => :destroy_account_session    
    # resource :password, :only => [:new, :create, :edit, :update], :controller => 'devise/passwords'    
  end
  
  match '/' => 'pages#show'
end
