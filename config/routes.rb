Al::Application.routes.draw do
  root to: 'home#index', via: :get
  get "/new", to: "new#index", as: :new
  post '/results' => 'home#save_email'
  resources :statements, path: "s" do
    collection do
      post 'create_and_agree'
    end
  end
  resources :comments, only: :create
  resources :votes, only: :create
  post '/vote', to: 'new#vote', as: :vote
  get '/entrepreneurs', to: 'static_pages#advice_for_entrepreneurs'
  post '/save_email' => 'individuals#save_email'
  post '/statements/quick' => 'statements#quick_create'
  resources :individuals, only: [:edit, :update, :destroy]
  match '/add_supporter' => 'agreements#add_supporter', via: [:get, :post]

  get '/contact' => 'static_pages#contact'
  get '/join' => 'static_pages#join'
  post '/emails' => 'static_pages#send_email'
  get '/about' => 'static_pages#about'

  match "/auth/twitter/callback" => 'sessions#create', via: [:get, :post]
  get "/signout" => "sessions#destroy", as: :signout
  resources :agreements, only: [:destroy]
  get '/test' => 'static_pages#polar'

  get "/auth/failure" => redirect("/")
  get "/brexit" => redirect("/s/should-the-united-kingdom-remain-a-member-of-the-european-union-sblrlc9vgxp7")
  post "/touch/:id" => 'agreements#touch', as: :touch

  post "/email" => 'static_pages#email'
  get "/terms" => "static_pages#terms", as: :terms
  get "/privacy" => "static_pages#privacy", as: :privacy
  get '/:id' => 'individuals#show', :as => :profile
end
