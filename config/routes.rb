Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :auth
      resources :users
    end
  end

  authenticated :user, lambda { |u| u.admin? } do
    namespace :admin do
      resources :comments, only: [:index, :destroy]
    end
  end

  authenticated :user do
    resource :onboarding, only: [:show, :create]

    resources :activities do
      resources :comments, only: [:create, :update], module: :activities do
        resource :reports, only: [:create], module: :comments
      end
      resources :participants, only: [:index, :create, :destroy], module: :activities
    end
    resources :athletes, only: [:show]
    namespace :cities do
      resource :autocomplete, only: [:show]
    end
    resource :dashboard, only: [:show]
    resource :profile, only: [:show, :edit, :update]
    resources :sports

    root to: "dashboards#show", as: :user_root
  end

  unauthenticated :user do
    get "/activities", to: "pages#activities"
    get "/profile", to: "pages#profile"
  end

  get "/privacy", to: "pages#privacy"
  get "/terms", to: "pages#terms"

  root to: "pages#home"
end

