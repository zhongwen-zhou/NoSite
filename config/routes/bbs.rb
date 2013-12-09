RubyChina::Application.routes.draw do
	namespace :bbs do
	  root :to => "home#index"
	  resources :sites
	  resources :pages, :path => "wiki" do
	    collection do
	      get :recent
	      post :preview
	    end
	    member do
	      get :comments
	    end
	  end
	  resources :comments
	  resources :notes do
	    collection do
	      post :preview
	    end
	  end
	  devise_for :users, :path => "account", :controllers => {
	      :registrations => :account,
	      :sessions => :sessions,
	      :omniauth_callbacks => "users/omniauth_callbacks"
	    }

	  delete "account/auth/:provider/unbind" => "users#auth_unbind", as: 'unbind_account'
	  post "account/update_private_token" => "users#update_private_token", as: 'update_private_token_account'

	  resources :notifications, :only => [:index, :destroy] do
	    collection do
	      post :clear
	    end
	  end

	  resources :nodes

	  get "topics/node:id" => "topics#node", as: 'node_topics'
	  get "topics/node:id/feed" => "topics#node_feed", as: 'feed_node_topics', defaults: { format: 'xml' }
	  get "topics/last" => "topics#recent", as: 'recent_topics'
	  resources :topics do
	    member do
	      post :reply
	      post :favorite
	      post :follow
	      post :unfollow
	      patch :suggest
	      delete :unsuggest
	    end
	    collection do
	      get :no_reply
	      get :popular
	      get :excellent
	      get :feed, defaults: { format: 'xml' }
	      post :preview
	    end
	    resources :replies
	  end

	  resources :photos
	  resources :likes

	  get "/search" => "search#index", as: 'search'

	end
end
