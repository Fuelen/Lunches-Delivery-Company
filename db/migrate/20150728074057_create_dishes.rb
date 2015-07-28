class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :name, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :kind, null: false, limit: 1
      t.date :available_on, null: false

      # t.timestamps null: false
    end
  end
end
