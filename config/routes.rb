SuperHero::Application.routes.draw do

  resources :sessions
	resources :battles
	resources :users do
    resources :user_heros do
      put :level_upgrade
      put :star_upgrade
      put :take
      put :takeoff
    end
  end
  root :to => "home#index"

#   resources :nodes

#   get "topics/node:id" => "topics#node", as: 'node_topics'
#   get "topics/node:id/feed" => "topics#node_feed", as: 'feed_node_topics', defaults: { format: 'xml' }
#   get "topics/last" => "topics#recent", as: 'recent_topics'
#   resources :topics do
#     member do
#       post :reply
#       post :favorite
#       post :follow
#       post :unfollow
#       patch :suggest
#       delete :unsuggest
#     end
#     collection do
#       get :no_reply
#       get :popular
#       get :excellent
#       get :feed, defaults: { format: 'xml' }
#       post :preview
#     end
#     resources :replies
#   end

#   resources :photos
#   resources :likes

#   get "/search" => "search#index", as: 'search'

  namespace :admin do
    root :to => "home#index"
    resources :sys_heros
    resources :sys_enemies
    resources :sys_game_levels do
    	resources :game_level_enemies
    end
  end

#   # WARRING! 请保持 User 的 routes 在所有路由的最后，以便于可以让用户名在根目录下面使用，而又不影响到其他的 routes
#   # 比如 http://ruby-china.org/huacnlee
#   get "users/city/:id" => "users#city", as: 'location_users'
#   get "users" => "users#index", as: 'users'
#   resources :users, :path => "" do
#     member do
#       get :topics
#       get :favorites
#       get :notes
#     end
#   end

end
