Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/logout', to: 'devise/sessions#destroy', as: 'logout'
  end

  resources :pages do
    resources :links, only: [:index]
  end

  root to: 'pages#index'
end
