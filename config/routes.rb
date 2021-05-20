Rails.application.routes.draw do
  resources :ehrs do
#    resources :compositions
    resources :monshins
    resources :diagnoses
  end

  root 'ehrs#index'
end
