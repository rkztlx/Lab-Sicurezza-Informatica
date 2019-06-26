class ChangeDefault < ActiveRecord::Migration
    
    def up
      change_column_default :users, :num_likes, 0
      change_column_default :users, :num_dislikes, 0
    end
  
    def down
        change_column_default :users, :num_likes, 1
        change_column_default :users, :num_dislikes, 1
    end

end