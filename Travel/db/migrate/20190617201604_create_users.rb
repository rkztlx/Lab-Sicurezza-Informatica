class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
        t.string 'name'
        t.string 'surname'
        t.date 'birth_date'
        t.string 'nickname'
        t.string 'email'
        t.string 'favorite_places'
        t.text 'bio'
        t.integer 'num_reviews'
        t.integer 'num_likes'
        t.timestamps
    end
  end
  
  def down
      drop_table 'users'
  end
end
