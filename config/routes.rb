Rails.application.routes.draw do
  resource :auth, only: %i[create]

  resources :entries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end