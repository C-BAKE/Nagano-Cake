class CreateOrderedItems < ActiveRecord::Migration[5.2]
  def change
    create_table :ordered_items do |t|
      t.integer :order_id
      t.integer :item_id
      t.integer :quantity
      t.integer :production_status, null: false, default: 0
      t.integer :price

      t.timestamps
    end
  end
end
