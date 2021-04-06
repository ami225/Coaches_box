class AddProfileImageIdToCoaches < ActiveRecord::Migration[5.2]
  def change
    add_column :coaches, :profile_image_id, :string
  end
end
