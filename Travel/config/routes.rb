Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places do
    resources :reviews do
      resources :likes
      resources :dislikes
    end
  end
  
  resources :users

  get 'places/:place_id/set_favorite/:id', to: 'users#favorite', as: 'set_favorite'

  get 'places/my_reviews/:id', to: 'users#reviews', as: 'my_reviews'
  
  get 'static_pages/home'

  root :to  => redirect('/static_pages/home')

end
