class RemoveFavoriteIdFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :favorite_id, :integer
  end
end
