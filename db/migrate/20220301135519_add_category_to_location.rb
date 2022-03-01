class AddCategoryToLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :category, :string
  end
end
