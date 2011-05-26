Zhuke::Application.routes.draw do
  #get \"users\/show\"

  root :to => "home#index"

  devise_for :users, :controllers => {:registrations => "registrations",
                                      #:sessions => "sessions",
                                      :password      => "devise/passwords",
                                      :invitations   => "invitations"}
  resources :users do
    member do
      post "follow"
      get "followers"
      post "unfollow"
    end
  end  
  
  resources :recipes do
    resources :comments
    member do
      post "share"
    end
  end
  
  # Show all the shared by me
  resources :shareds
  
end
