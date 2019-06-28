class AddIconToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :icon, :string
  end
end
