RubyChina::Application.routes.draw do
	namespace :league do
	  root :to => "home#index"
	  resources :leagues do
	  	member do
	  		put :ask_for_join
	  		put :agree_join
	  	end
	  end
	end
end
