class AddTypeToLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :locations, :type, :string
  end
end
