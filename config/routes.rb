Rails.application.routes.draw do
  # Mount Swagger UI for browsing the documentation
  mount Rswag::Ui::Engine => '/api-docs'

  # Serve the static swagger.yaml file located in public/swagger/v1
  get '/api-docs/v1/swagger.yaml', to: redirect('/swagger/v1/swagger.yaml')

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # sessions routes
  post '/login', to: 'sessions#create'

  # transactions routes
  post '/transaction/create', to: 'transactions#transfer'
  get '/transactions/history', to: 'transactions#history'
  get '/transactions/history/:id', to: 'transactions#detail'

  # stock routes
  get '/stock/price/all', to: 'stocks#all_price'
  get '/stock/price/:symbol', to: 'stocks#price_by_symbol'
  get '/stock/prices/:symbols', to: 'stocks#price_by_symbols'
  post '/stock/sync', to: 'stocks#sync_stock_prices'

  # wallet routes
  get '/wallet/balances', to: 'wallet#balances'
end
