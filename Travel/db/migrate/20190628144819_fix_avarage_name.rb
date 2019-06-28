class FixAvarageName < ActiveRecord::Migration[5.2]
  def change
    rename_column :places, :avarage, :average
  end
end
