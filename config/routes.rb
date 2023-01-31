Rails.application.routes.draw do
  devise_for :users

  resources :activities
  resources :sports

  root "sports#index"
end
