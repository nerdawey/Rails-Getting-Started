class CreateProductSubscribers < ActiveRecord::Migration[8.1]
  def change
    create_table :product_subscribers do |t|
      t.references :product, null: false, foreign_key: true
      t.references :subscriber, null: false, foreign_key: true

      t.timestamps
    end
  end
end
