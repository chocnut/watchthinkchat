require 'constraints/domain_constraint'
Godchat::Application.routes.draw do
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
     delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  authenticated :user do
    get 'me', to: "operators#index", as: :operator_dashboard
  end

  constraints Constraints::DomainConstraint.new(ENV['operator_app_url']) do
    root to: "site#index"
    get '/tour', to: "site#tour", as: :tour
    get '/features', to: "site#features", as: :features
    post '/pusher/presence' => 'pusher#presence'
    get '/find_friends' => 'friends#find'
    #get '/c/:channel', action: 'index', controller: 'operators', as: :channel_conversation
    get '/:campaign_id', to: "site#index" # angular will handle the correct view
  end

  get '/o/:code', to: "visitors#index"
  root to: "visitors#index", as: :campaign_root

  namespace :api, defaults: {format: :json} do
    resources :campaigns
    resources :chats do
      resources :messages
    end
  end
end
