Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :places do
    resources :reviews, only: [:new, :create, :destroy] do
      resources :likes
      resources :dislikes
    end
  end
  
  resources :users

  root :to  => redirect('/places')

end
