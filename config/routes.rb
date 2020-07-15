Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :authors, only: [:new, :create, :show]
  resources :auths, only: [:new, :create, :destroy]
  resources :books, only: [:new, :create, :index]
  resources :libraries, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  root :to => "auths#new" #, :id => '1'
  get 'store', :to => 'books#store'
end
