class ChangeDefaultvalueForLikes < ActiveRecord::Migration 
    
    def change 
      change_column_default :users, :num_likes, 0
      change_column_default :users, :num_dislikes, 0
    end

end