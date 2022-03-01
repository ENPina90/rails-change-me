class RemoveTypeFromLocation < ActiveRecord::Migration[6.1]
  def change
    remove_column :locations, :type, :string
  end
end
