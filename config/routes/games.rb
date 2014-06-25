NoSite::Application.routes.draw do
	namespace :games do
		namespace :gcld do
			namespace :auction do
				get :auction_princes_index# => 'auction#auction_princes_index'
				post :auction_prince

				get :auction_generals_index# => 'auction#auction_princes_index'
				post :auction_general

				get :search_auction_generals# => 'auction#auction_princes_index'
			end
	  	end
	end
end
