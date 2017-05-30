class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :ratingable, polymorphic: true, index: true
      t.integer :rating
      t.text :comment

      t.timestamps null: false
    end
  end
end
