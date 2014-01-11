SuperHero::Application.routes.draw do

  resources :sessions
	resources :battles
	resources :users do
    resources :user_heros do
      post :level_upgrade
      post :star_upgrade
      put :take
      put :takeoff
    end
  end
  root :to => "home#index"


  namespace :admin do
    root :to => "home#index"
    resources :sys_heros do
      resources :hero_star_upgrades
    end
    resources :sys_enemies
    resources :sys_game_levels do
    	resources :game_level_enemies
    end
  end

end
