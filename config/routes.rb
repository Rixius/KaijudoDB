Rails.application.routes.draw do
  post '/decks/:id/manage', to: 'decks#manage', as: 'deck_manage'
  get '/decks/:id/scope', to: 'decks#scope', as: 'deck_scope'
  resources :decks do
  end

  root to: 'static#index'
  get 'about' => 'static#about'
  get 'contact' => 'static#contact'

  devise_for :users
  devise_scope :user do
      get 'users/sign_out' => 'devise/sessions#destroy'
  end

  resource 'card' do
      root to: 'card#list', as: 'index'
      get 'show/:slug', to: 'card#show', as: ''
      get 'search', to: 'card#search', as: 'search'
  end

  get 'config/show/:format', to: 'card#show_format', as: 'card_format'

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
