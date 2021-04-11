class CreateUserEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :user_entries do |t|
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
