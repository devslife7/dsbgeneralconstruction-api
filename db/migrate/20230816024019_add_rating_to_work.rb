class AddRatingToWork < ActiveRecord::Migration[7.0]
  def change
    add_column :works, :ratings, :integer, array: true, default: []
  end
end
