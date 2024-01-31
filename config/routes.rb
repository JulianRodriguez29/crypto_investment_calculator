Rails.application.routes.draw do
  resources :investments, only: [:index, :new, :create]
  root to: 'investments#index'
end
