Zhuke::Application.routes.draw do
  #get \"users\/show\"

  root :to => "home#index"

  devise_for :users, :controllers => {:registrations => "registrations",
                                      #:sessions => "sessions",
                                      :password      => "devise/passwords",
                                      :invitations   => "invitations",
                                      :omniauth_callbacks => "users/omniauth_callbacks" } do
    get "/register", :to => "devise/registrations#new" 
    get "/login", :to => "devise/sessions#new" 
    get "/logout", :to => "devise/sessions#destroy"
  end
  
  # omniauth client stuff
  match '/auth/:provider/callback', :to => 'users#auth_callback'
  match '/auth/failure', :to => 'users#auth_failure'
    
  resources :users do
    member do
      get "following"
      post "follow"
      get "followers"
      post "unfollow"
    end
  end  
  
  resources :recipes do
    resources :comments, :controller => "comments"
    member do
      post "share"
    end
  end
  
  # Show all the shared by me
  resources :shareds
  
end
