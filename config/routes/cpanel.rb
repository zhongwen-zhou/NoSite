RubyChina::Application.routes.draw do
  namespace :cpanel do
    root :to => "home#index"
    resources :users
    resources :articles
    namespace :bbs do
      resources :site_configs
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
