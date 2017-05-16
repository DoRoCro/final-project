class CreateBurgers < ActiveRecord::Migration
  def change
    create_table :burgers do |t|
      t.string :description
      t.references :restaurant, index: true, foreign_key: true
      t.decimal :price, precision: 5, scale: 2
      t.integer :rating

      t.timestamps null: false
    end
  end
end
