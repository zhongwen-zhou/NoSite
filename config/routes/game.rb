NoSite::Application.routes.draw do
	namespace :game do
		post 'guess' => "sysgame#guess"
	end
end
