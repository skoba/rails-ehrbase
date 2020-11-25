Rails.application.routes.draw do
  resources :ehrs do
    resources :compositions
  end

  root 'ehrs#index'
end
