Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "clients/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places
  resources :users
  resources :reviews

  get 'places/:place_id/like_review/:id', to: 'reviews#like', as: 'i_like_review'

  root :to  => redirect('/places')

end
