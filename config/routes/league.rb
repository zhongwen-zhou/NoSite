NoSite::Application.routes.draw do
	namespace :league do
	  root :to => "home#index"
	  resources :leagues do

	  	collection do
	  		get :search
	  	end

	  	resources :members, :only => [] do
	  		get :set_vice_president
	  		get :cancel_vice_president
	  		get :set_conductor
	  		get :cancel_conductor
			get :set_spokesman
	  		get :cancel_spokesman
	  	end

	  	resources :messages, :only => [:index, :create]

	  	member do
	  		post :welfare
	  		put :ask_for_join
	  		put :agree_join
	  		put :refuse_join
	  		put :sign_today
	  		get :proclaim_war
	  	end
	  end
	end
end
