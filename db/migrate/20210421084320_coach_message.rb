class CoachMessage < ActiveRecord::Migration[5.2]
  def change
    drop_table :coach_messages
    drop_table :user_messages
  end
end
