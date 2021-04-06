class AddIntroductionToCoaches < ActiveRecord::Migration[5.2]
  def change
    add_column :coaches, :introduction, :text
  end
end
