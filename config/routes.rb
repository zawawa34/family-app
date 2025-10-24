Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :user_database_authentications, path: "users", class_name: "User::DatabaseAuthentication", controllers: {
    sessions: "user/sessions",
    registrations: "user/registrations"
  }

  # Invitation management
  resources :invitations, only: [ :index, :create ], controller: "user/invitations"

  # Shopping list management
  resources :shopping_lists, only: [ :index ] do
    # Shopping items (短縮URL: items)
    resources :items, only: [ :create, :edit, :update, :destroy ], controller: 'shopping_items' do
      # 商品のピック状態リソース（singular resource）
      resource :pick, only: [ :create, :destroy ], controller: 'shopping_items/picks'
    end
    # カート内商品の一括削除（singular resource）
    resource :picked_items, only: [ :destroy ], controller: 'shopping_lists/picked_items'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
