class AddColumnsToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :coach_id, :integer
    add_column :posts, :favorite_id, :integer
  end
end
