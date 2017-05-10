class UpdatePriceWithPrecision < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :price, :decimal, precision: 16, scale: 2
  end
end
