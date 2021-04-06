class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user,type: :bigint, foreign_key: true
      t.references :room,type: :bigint, foreign_key: true
      t.references :coach,type: :bigint, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
