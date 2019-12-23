Rails.application.routes.draw do
  default_url_options Settings.default_url_options.symbolize_keys

  namespace :admin do
    root to: 'machines#index'
    resources :machines
  end

  scope module: 'mobile' do
    root to: 'welcome#index'
    get '/m/:slug', to: 'machines#show', as: :slug

    resources :machines, only: [:show]
    resources :payments do
      member do
        get 'success'
        get 'fail'
      end
    end
  end

  # CloudPayments's callback JSON API
  #
  resources :notifications, only: [] do
    collection do
      post 'success'
      post 'fail'
    end
  end
end
