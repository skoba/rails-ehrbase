Rails.application.routes.draw do
  resources :people do
    resources :compositions
  end

  root 'people#index'
end
