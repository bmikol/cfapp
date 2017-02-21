class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :product_id
      t.string :integer
      t.float :total
    end
    add_index :orders, :user_id
    add_index :orders, :integer
  end
end
