Rails.application.routes.draw do
  resources :investments, only: [:index, :new, :create]
  root to: 'investments#index'

  mount ActionCable.server => '/cable'

  resources :investments do
    collection do
      get 'export_json', defaults: { format: 'json' }
      post 'export_json', defaults: { format: 'json' }
      get 'export_csv', defaults: { format: 'csv' }
      post 'export_csv', defaults: { format: 'csv' }
    end
  end
end
