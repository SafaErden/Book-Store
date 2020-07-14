Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :authors, only: [:new, :create, :show]
  resources :auths, only: [:new, :create]
  root :to => "auths#new" #, :id => '1'
end
