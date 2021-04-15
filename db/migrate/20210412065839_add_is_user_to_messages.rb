class AddIsUserToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :is_user, :boolean
  end
end
