class CreatePlaces < ActiveRecord::Migration[5.2]
  def up
    create_table  'places' do |t|
      t.string 'name'
      t.string 'street'
      t.integer 'address'
      t.string 'city'
      t.string 'telephone_number'
      t.time 'opening_time'
      t.time 'closing_time'
      t.text 'description'
      t.text 'notices'
      t.timestamps
    end
  end

  def down
    drop_table 'places'
  end
end

