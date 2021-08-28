Rails.application.routes.draw do
  # get 'diagnoses_lists/index'
  # get 'diagnoses_lists/show'

  resources :templates
  resources :queries
  
  resources :ehrs do
#    resources :compositions
    resources :monshinsb
    resources :diagnoses
    resources :diagnoses_lists
#    get 'search' => 'diagnoses#search'
  end

  root 'ehrs#index'
end
