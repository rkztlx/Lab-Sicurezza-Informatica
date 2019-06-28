class RemoveNumReviewsFromUsers < ActiveRecord::Migration[5.2]
  def change
    connection.execute("PRAGMA defer_foreign_keys = ON")
    connection.execute("PRAGMA foreign_keys = OFF")
    rename_column :users, :num_reviews, :num_dislikes
    connection.execute("PRAGMA foreign_keys = ON")
    connection.execute("PRAGMA defer_foreign_keys = OFF")
  end
end
