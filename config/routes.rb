Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: "user/sessions", registration: "user/registrations" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root 'profiles#index'

  resources :users do
		resources :groups do
      resources :subscriptions, only: [:create]
    end
    resources :profiles
    resources :walls, only: [:show] do
      resources :posts, only: [:create, :show] do
        resources :comments, only: [:create, :index]
      end
    end
    resources :friendships, only: [:create, :destroy]
    resources :feed_histories, only: [:show]
  end

  resources :groups, only: [:show, :destroy]
  resources :tags, only: [:index]

  patch 'friendships/read_requests' => 'friendships#read_requests'
  patch 'friendships/accept_friendship/:id' => 'friendships#accept_friendship'
  patch 'friendships/decline_friendship/:id' => 'friendships#decline_friendship'
  patch 'notifications/read_notifications/' => 'notifications#read_notifications'
  post  'posts/like' => 'posts#like'
  post  'comments/like' => 'comments#like'
  get 'comments/check_for_like' => 'comments#check_for_like'
  get 'users/:user_id/feed_histories/:id/sort_by_date' => 'feed_histories#sort_by_date'
  get 'users/:user_id/feed_histories/:id/sort_by_recommended' => 'feed_histories#sort_by_recommended'
  delete 'users/:user_id/groups/:group_id/subscriptions' => 'subscriptions#delete', as: :destroy_subscription

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase


  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
