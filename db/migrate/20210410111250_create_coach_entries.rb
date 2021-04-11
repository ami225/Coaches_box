class CreateCoachEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :coach_entries do |t|
      t.integer :coach_id
      t.integer :room_id

      t.timestamps
    end
  end
end
