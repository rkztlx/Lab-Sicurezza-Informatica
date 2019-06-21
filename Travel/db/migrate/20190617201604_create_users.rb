class CreateUsers < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
        t.string 'name'
        t.string "provider"
        t.string "uid"
        t.string 'surname'
        t.date 'birth_date'
        t.string 'nickname'
        t.references 'favorite_place'
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
