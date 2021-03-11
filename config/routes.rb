Rails.application.routes.draw do
  resources :ehrs do
    resources :compositions
    resources :monshins
  end


  root 'ehrs#index'
end
