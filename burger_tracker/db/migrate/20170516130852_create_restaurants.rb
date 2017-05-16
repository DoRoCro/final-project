class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.references :address, index: true, foreign_key: true
      t.string :franchise

      t.timestamps null: false
    end
  end
end
