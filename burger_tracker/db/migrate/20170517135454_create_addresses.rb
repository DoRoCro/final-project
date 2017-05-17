class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_addr
      t.string :street
      t.string :area
      t.string :city
      t.string :post_code
      t.string :phone_no

      t.timestamps null: false
    end
  end
end
