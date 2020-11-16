Rails.application.routes.draw do
  resources :compositions
  resources :people
  root 'people#index'
end
