class CreateReviews < ActiveRecord::Migration[5.2]
  
  def up
    create_table :reviews do |t|
      t.integer 'rating'
      t.text 'comments'
      t.references 'user'
      t.references 'place'
      t.integer 'likes'
      t.integer 'dislikes'
    end
  end
  
  def down
    drop_table 'reviews'
  end

end
