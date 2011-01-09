AuthTest::Application.routes.draw do
  resources :developer_notes

  match 'entries/createinline' => 'entries#createinline'
  match 'entries/removeinline' => 'entries#removeinline'
  resources :entries

  resources :charts
  match 'charts/overview/:id'=> 'charts#overview'
  
  match 'users/invite_delete/:id' => 'users#invite_delete'
  match 'users/invite_accept/:id' => 'users#invite_accept'
  match 'users/invite_ignore/:id' => 'users#invite_ignore'
  match 'users/invite_add/:username' => 'users#invite_add'
  match 'users/become' => 'users#become'
  match 'users/login_browserstats' => 'users#login_browserstats'
  resources :users
  
  match 'home' => 'users#home'
  match 'signout' => 'users#signout'

  match '/twitter_callback' => 'users#proc_twitter_login'
  match '/auth/twitter/callback' => 'users#proc_twitter_login'
  root :to => "users#login"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
