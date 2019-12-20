Rails.application.routes.draw do
  root to: 'machines#index'
  resources :machines
end
