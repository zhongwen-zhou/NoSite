NoSite::Application.routes.draw do
	namespace :games do
		namespace :gcld do
			namespace :auction do
				get :auction_princes_index# => 'auction#auction_princes_index'
				post :auction_prince
			end
	  	end
	end
end
