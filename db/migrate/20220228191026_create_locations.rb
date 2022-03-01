class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :hours
      t.string :notes

      t.timestamps
    end
  end
end
