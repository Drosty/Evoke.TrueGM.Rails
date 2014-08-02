EvokeTruegmRails::Application.routes.draw do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"},
                     controllers: {omniauth_callbacks: "omniauth_callbacks"}, :path_prefix => 'd'

  scope "/users/:user_id" do
    resources :external_link
  end

  resources :leagues, :only => [:show, :index]  do
    resources :nfl_players, :only => [:index, :show], :path => 'player'
    resources :forum_topics, :path => "topics" do
      resources :forum_posts, only: [:new, :create, :destroy]
    end
    get 'schedule/:week' => "schedule#index", as: 'schedule'
  end

  resources :teams, :only => [:show]
  resources :trades
  resources :nflteams, :only => [:index, :show]
  resources :users
  resources :invites

  namespace :admin do
    get "/" => "leagues#index"

    resources :leagues
    resources :teams, :only => [:index, :show, :edit, :update]
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'welcome#index'

end
