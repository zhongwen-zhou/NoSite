RubyChina::Application.routes.draw do
	namespace :league do
	  root :to => "home#index"
	  resources :leagues do

	  	resources :members, :only => [] do
	  		get :set_vice_president
	  		get :canel_vice_president
	  		get :set_conductor
	  		get :canel_conductor
	  	end

	  	resources :messages, :only => [:index, :create]

	  	member do
	  		post :welfare
	  		put :ask_for_join
	  		put :agree_join
	  		put :sign_today
	  	end
	  end
	end
end
