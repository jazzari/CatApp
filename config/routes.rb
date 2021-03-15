Rails.application.routes.draw do
  
  resources :breeds, only: [:show, :index, :destroy]
  resources :cats, only: [:show, :index, :destroy]

end
