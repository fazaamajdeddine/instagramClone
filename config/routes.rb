Rails.application.routes.draw do
  devise_for :users
  #get "posts#new"
  #post "posts/new", to: "posts#create"
  
  #post '/users/:id/follow', to: "users#follow", as: "follow_user"
  #post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  
  get "/profile/:username" => "users#profile", as: :profile
  devise_scope :user do
    authenticated :user do
      root to: "posts#index", as: :authenticated_root
    end
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  
  resources :posts do 
    resources :comments 
  end
  
   
  resource :follows, only: [:create, :destroy]
  resource :comments, only: [:create]
   
resources :posts do 
  member do 
    put "like" => "posts#vote"
  end
end
  resources :conversations do 
    resources :messages
  end
  resources :users
  #get "search", to: "users#index"
  #get '/search' => 'users#search', :as => 'search_page'

end