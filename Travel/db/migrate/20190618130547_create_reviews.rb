class CreateReviews < ActiveRecord::Migration[5.2]
  def up
    create_table :reviews do |t|
        t.text 'description'
        t.string 'user'
        t.string 'place'
        t.timestamps
    end
  end
  
  def down
      drop_table 'reviews'
  end
end
