Al::Application.routes.draw do
  root to: 'static_pages#home', via: :get
  resources :statements, path: "s" do
    collection do
      post 'create_and_agree'
    end
  end
  resources :comments, only: :create
  get '/entrepreneurs' => 'static_pages#advice_for_entrepreneurs'
  get '/statement' => 'statements#new_and_agree'
  post '/save_email' => 'individuals#save_email'
  post '/statements/quick' => 'statements#quick_create'
  resources :individuals, only: [:edit, :update, :destroy]
  match '/add_supporter' => 'statements#add_supporter', via: [:get, :post]
  get '/contact' => 'static_pages#contact'
  get '/join' => 'static_pages#join'
  post '/emails' => 'static_pages#send_email'
  match "/auth/twitter/callback" => 'sessions#create', via: [:get, :post]
  get "/signout" => "sessions#destroy", as: :signout
  resources :agreements, only: [:destroy]
  get '/test' => 'static_pages#polar'

  get "/auth/failure" => redirect("/")

  get '/:id' => 'individuals#show', :as => :profile
end
