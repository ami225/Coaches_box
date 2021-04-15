class CreateTagRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :tag_relationships do |t|
      t.integer :coach_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :tag_relationships, [:coach_id,:tag_id],unique: true
  end
end
