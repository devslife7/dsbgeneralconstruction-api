class AddAvatarToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :avatar, :string
  end
end
