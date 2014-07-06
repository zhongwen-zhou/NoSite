NoSite::Application.routes.draw do
  namespace :cpanel do
    root :to => "home#index"
    resources :users
    resources :articles
    resources :badges
    resources :site_configs

    resources :guess_balls, :only =>[:index] do
      collection do
        get :edit_teams
        get :edit_results
        post :update_teams
        post :update_results
      end
    end

    namespace :games do
      namespace :gcld do
        resources :castellans do
          collection do
            post :start_auction_zhaizhu
            post :start_auction_generals
          end
        end
      end
    end

    namespace :bbs do
      resources :replies
      resources :topics do
        member do
          post :suggest
          post :unsuggest
          post :undestroy
        end
      end
      resources :nodes
      resources :sections
      resources :photos
      resources :pages do
        resources :versions, :controller => :page_versions do
          member do
            post :revert
          end
        end
      end
      resources :comments
      resources :site_nodes
      resources :sites
      resources :locations
    end
  end
end
