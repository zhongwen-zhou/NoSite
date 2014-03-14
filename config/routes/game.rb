NoSite::Application.routes.draw do
	namespace :game do
		get 'guess' => "sysgame#guess"
	end
end
