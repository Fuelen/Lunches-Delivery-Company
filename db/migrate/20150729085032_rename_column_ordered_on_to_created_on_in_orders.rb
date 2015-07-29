class RenameColumnOrderedOnToCreatedOnInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :ordered_on, :created_on
  end
end
