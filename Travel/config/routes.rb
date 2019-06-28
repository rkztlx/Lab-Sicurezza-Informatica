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

  get '/places/:place_id/set_favorite/:id', to: 'users#favorite', as: 'set_favorite'

  get '/places/my_reviews/:id', to: 'users#reviews', as: 'my_reviews'

  get '/users/:id/ban', to: 'users#ban', as: 'ban_user'

  get '/users/:id/unban', to: 'users#unban', as: 'unban_user'

  get '/users/:id/promote', to: 'users#promote', as: 'promote_user'
  
  get '/users/:id/demote', to: 'users#demote', as: 'demote_user'
  
  get 'static_pages/home'
  
  get 'static_pages/help'
  
  root :to  => redirect('/static_pages/home')

end
