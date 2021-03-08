Rails.application.routes.draw do
  
  resources :breeds, only: [:show, :index, :destroy]
end
