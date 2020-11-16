Rails.application.routes.draw do
  root 'compositions#index'
  resources :compositions
end
