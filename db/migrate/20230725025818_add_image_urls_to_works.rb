class AddImageUrlsToWorks < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :image_urls, :string, array: true, default: []
  end
end
