class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :label
      t.decimal :discount_rate
      t.decimal :money_off
      t.datetime :start_date
      t.datetime :end_date
      t.references :restaurant, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
