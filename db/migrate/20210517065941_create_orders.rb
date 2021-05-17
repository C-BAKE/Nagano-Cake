class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :end_user_id
      t.integer :postage
      t.integer :payment
      t.integer :payment_method, null: false, default: 0
      t.integer :order_status, null: false, default: 0
      t.string :name
      t.string :address
      t.string :postal_code

      t.timestamps
    end
  end
end
