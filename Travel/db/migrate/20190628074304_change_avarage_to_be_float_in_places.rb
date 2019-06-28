class ChangeAvarageToBeFloatInPlaces < ActiveRecord::Migration[5.2]
  def change
      change_column :places, :avarage, :float
  end
end
