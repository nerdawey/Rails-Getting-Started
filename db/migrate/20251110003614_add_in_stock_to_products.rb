class AddInStockToProducts < ActiveRecord::Migration[8.1]
  def change
    add_column :products, :in_stock, :boolean, default: false
  end
end
