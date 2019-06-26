class AddAvarageToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :avarage, :integer
  end
end
