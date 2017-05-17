class CreateBurgerDeals < ActiveRecord::Migration
  def change
    create_table :burger_deals do |t|
      t.integer :burger_id
      t.integer :deal_id

      t.timestamps null: false
    end
  end
end
