Canard::Abilities.for(:admin) do
  
  can [:read, :create, :destroy], Place
  cannot [:update], Place
  can [:read, :create, :update, :destroy], Review
  can [:read, :create, :update, :destroy], User
  
end
