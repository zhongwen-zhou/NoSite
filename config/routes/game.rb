NoSite::Application.routes.draw do
	namespace :game do
		post 'guess' => "sysgame#guess"
	  # root :to => "home#index"
	  # resources :communications, :only => [:index] do
	  # 	collection do
	  # 		get :start
	  # 	end
	  # 	member do
	  # 		resources :messages
	  # 	end
	  # end
	end
end
