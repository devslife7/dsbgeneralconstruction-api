class AddImagesToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :images, :string, array: true, :default => []
  end
end
