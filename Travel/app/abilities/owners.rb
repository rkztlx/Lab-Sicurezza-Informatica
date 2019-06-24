Canard::Abilities.for(:owner) do
  
  can [:read, :create, :update, :destroy], Place
  can [:read, :create, :update, :destroy], Review
  can [:read, :create, :update, :destroy], User
  
end
