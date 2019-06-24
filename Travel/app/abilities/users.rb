Canard::Abilities.for(:user) do
  
  can [:read, :create], Place
  cannot [:destroy, :update], Place
  can [:read, :create, :update, :destroy], Review
  can [:read, :create, :update, :destroy], User
  
end
