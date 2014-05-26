NoSite::Application.routes.draw do
	namespace :message do
	  root :to => "home#index"
	  resources :sys_messages, :only => [:index]
	  resources :communications, :only => [:index, :destroy] do
	  	collection do
	  		get :start
	  	end
	  	member do
	  		resources :messages
	  	end
	  end
	end
end
