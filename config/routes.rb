Rails.application.routes.draw do
  default_url_options Settings.default_url_options.symbolize_keys

  root to: 'machines#index'
  get '/m/:slug', to: 'machines#show', as: :slug

  resources :machines do
    member do
      get 'status'
    end
  end

  resources :payments do
    member do
      get 'success'
      get 'fail'
    end
  end

  resources :notifications, only: [] do
    collection do
      post 'success'
      post 'fail'
    end
  end
end
