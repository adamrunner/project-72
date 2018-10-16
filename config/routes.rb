Rails.application.routes.draw do
  namespace :api do
    resources :users, except: %w[index] do
      post :authenticate, on: :collection
    end
  end
  root :to => "application#index"
  match "*path", to: "application#index", format: false, via: :get
end