Rails.application.routes.draw do
  devise_for :clients, :controllers => { :omniauth_callbacks => "clients/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places
  resources :users
  resources :reviews

  root :to  => redirect('/places')

end
