class CreateCoachMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :coach_messages do |t|
      t.integer :message_id
      t.integer :coach_id

      t.timestamps
    end
  end
end
