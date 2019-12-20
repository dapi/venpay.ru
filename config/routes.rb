Rails.application.routes.draw do
  root to: 'machines#index'
  resources :machines

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
