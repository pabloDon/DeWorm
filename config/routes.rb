Rails.application.routes.draw do
  get 'login' => 'user_sessions#new', as: :login
  get 'logout' => 'user_sessions#destroy', as: :logout

  #get 'users/new'

  #get 'users/edit'

  get 'index_project' => 'statics#index' , as: :index_project
  root 'statics#homepage' #Will be root
  get 'not_found' => 'statics#not_found' , as: :not_found
  
  post 'attachments' => 'attachments#create', as: :create_attachment
  
  post 'search_bug' => 'bugs#search_bug', as: :search_bug
  get 'timeline' => 'bugs#timeline', as: :timeline
  
  get 'my_profile' => 'users#edit', as: :my_profile
  get 'select_project/:id' => 'projects#select_project', as: :select_project
  
  post 'invite_user' => 'projects#invite_user', as: :invite_user

  resources :notes
  resources :bugs
  resources :projects
  resources :users
  resources :user_sessions

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
