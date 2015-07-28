class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.date    :ordered_on,      null: false
      t.integer :first_course_id, null: false
      t.integer :main_course_id,  null: false
      t.integer :drink_id,        null: false

      # t.timestamps null: false
    end
  end
end
