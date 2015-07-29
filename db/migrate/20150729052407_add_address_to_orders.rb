class AddAddressToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address, :string, null: false
  end
end
