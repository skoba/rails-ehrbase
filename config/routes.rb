Rails.application.routes.draw do
  # get 'diagnoses_lists/index'
  # get 'diagnoses_lists/show'

  resources :ehrs do
#    resources :compositions
    resources :monshins
    resources :diagnoses
    resources :diagnoses_lists
  end

  root 'ehrs#index'
end
