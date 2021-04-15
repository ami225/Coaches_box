class PostCategoryRelations < ActiveRecord::Migration[5.2]
  def change
    drop_table :post_category_relations
  end
end
