Rails.application.routes.draw do

  #devise_for :crmusers
  devise_for :crmusers, :skip => [:sessions]
  as :crmuser do
    get '/signin' => 'devise/sessions#new', :as => :new_crmuser_session
    post '/signin' => 'devise/sessions#create', :as => :crmuser_session
    delete '/logout' => 'devise/sessions#destroy', :as => :destroy_crmuser_session
  end

  authenticated :crmuser do
    root :to => redirect('/crm/domains'), as: :authenticated_root
    # Rails 4 users must specify the 'as' option to give it a unique name
    # root :to => "main#dashboard", :as => "authenticated_root"
  end

  # # devise_scope :crmuser do
  # #   authenticated :crmuser do
  # #     root 'crm/domains#index', as: :authenticated_root
  # #   end

  # #   unauthenticated do
  # #     root 'devise/sessions#new', as: :unauthenticated_root
  # #   end
  # # end


  namespace :crm do
    resources :accesses
  end

  namespace :crm do
    resources :domains
  end


  root :to => redirect('/signin')

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
    #user_root 'crm/domains#index'
    #root 'devise/sessions#new', :as => :new_user_session

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
