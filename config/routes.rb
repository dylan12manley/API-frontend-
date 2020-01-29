Rails.application.routes.draw do
  root to: 'destinations#index'
  resources :destinations do
    resources :reviews
  end
end
