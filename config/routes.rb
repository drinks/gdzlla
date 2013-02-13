GDZLLA::Application.routes.draw do

  resources :users, except: [:index, :create] do
    resources :posts, only: [:index]
    get 'setup-flickr', action: 'setup_flickr', as: :setup_flickr_for, on: :member
  end
  get 'finish-flickr' => 'users#finish_flickr', as: :finish_flickr

  resources :posts, only: [:show, :create]

  get 'login' => 'sessions#new', as: :new_session
  get 'logout' => 'sessions#destroy', as: :destroy_session
  get 'oauth-callback' => 'sessions#create', as: :create_session

  post 'go/:service' => 'posts#create_from'
  post 'go' => 'posts#create'

  get 'about' => 'content#about'
  get 'help' => 'content#help'

  get ':id' => 'posts#show', constraints: {id: /[a-zA-Z0-9]+/}
  root to: 'content#index'

end
