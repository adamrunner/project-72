Rails.application.routes.draw do
  resources :users, except: %w[index] do
    post :authenticate, on: :collection
  end

  resources :entries
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end