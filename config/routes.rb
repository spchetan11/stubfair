Rails.application.routes.draw do
 
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'welcome#index'
  #  devise_scope :user do
  # #   # using login path for registration
  # #   get '/login' => 'registrations#new', :as => :new_user_registration
  # #   post '/signup' => 'registrations#create', :as => :user_registration
  #    post '/signin' => 'sessions#create', :as => :user_session
  #  end
  devise_for :users
  

  #post "/tickets/:id" => "tickets#show"
  

  post "/transactions/:id" => "transactions#paypal_redirect", as: :transaction

  post "/hook" => "transactions#hook"
  

  resources :users
  resources :events
  resources :devise
  #resources :sessions
  resources :tickets

 

  get 'welcome/index' => 'welcome#index'

  get '/band/' => 'bands#band'

  get 'event/search_result' => 'events#search_result'

  get 'ticket/new' => 'events#search'

  get 'ticket/search_result' => 'events#search'

  post 'ticket/search_result' => 'events#ticket_step1'

  get "my_events" => "events#my_events"

  get '/cart' => 'cart#index' #same as get 'cart/index'

  get '/cart/clear' => 'cart#clearCart'

  post '/cart/:id' => 'cart#add'

  get '/cart/checkout/:id' => 'cart#checkout'

  get '/transactions/purchase/:id' => 'transactions#purchase'
 
 #was
  #get '/tickets/new/:events_id' => 'tickets#new'
  get '/tickets/new/:event_id' => 'tickets#new'

  get '/users/:id' => 'users#show'

  get '/search' => 'searches#index'

  post '/events/user_events' => 'events#user_events'

  #post '/search' => 'searches#search'

  get "/concerts" => "events#concerts", as: :concerts

  get "/theatre" => "events#theatre", as: :theatre

  get "/sports" => "events#sports", as: :sports

  get "/comedy" => "events#comedy", as: :comedy

  get "/festivals" => "events#festivals", as: :festivals

  get "/family" => "events#family", as: :family

  get "/deals" => "events#deals", as: :deals

  get "/other" => "events#other", as: :other

  get "/upcoming" => "events#upcoming", as: :upcoming

  post "/events/ticket_step1" => "events#ticket_step1", as: :events_ticket_step1

  post "/events/popular_events" => "events#popular_events", as: :popular_events

  

  match ':controller(/:action(/:id))',:via => [:get, :post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  #root 'welcome#index'

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
