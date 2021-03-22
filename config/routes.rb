Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  resources :breeds, only: [:show, :index, :destroy]
  resources :cats, only: [:show, :index, :destroy]

end
