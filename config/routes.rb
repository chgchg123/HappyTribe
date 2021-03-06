Rails.application.routes.draw do

  root 'events#index'

  resources :organizations do
    resources :events, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :events, only: [:index]
  resources :events, only: [:show] do
    resources :bookmarks, only: [:create, :destroy]
  end
  resources :timeslots do
    resources :arrangements, only: [:new, :edit, :show, :create, :update, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :edit, :show, :create, :update] do
    resources :managed_organizations, only: [:index]
  end
  resources :welcomes, only: [:index]
  resources :conversations, only: [:index, :show, :new, :create] do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  get '/welcome' => 'welcomes#index'
  get '/login' => 'sessions#new'
  delete '/logout' => 'sessions#destroy'
  get '/signup' => 'users#new'

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  get 'mailbox/inbox' => "mailboxes#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailboxes#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailboxes#trash", as: :mailbox_trash

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
