Rails.application.routes.draw do
  root to: "home#index"

  resources :users, only: [:new, :create]
  put "decks/:id/current", to: "users#set_current_deck", as: "set_current"

  resources :user_sessions, only: [:new, :create, :destroy]
  get "login", to: "user_sessions#new", as: "login"
  get "logout", to: "user_sessions#destroy", as: "logout"

  resources :decks, except: [:show] do
    resources :cards
  end

  put "check", to: "cards#check", as: "check_card"
  put "set_score", to: "cards#set_score", as: "set_score_card"

  post "oauth/callback", to: "oauths#callback"
  get "oauth/callback", to: "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider", to: "oauths#oauth", as: "auth_at_provider"

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
#
end
