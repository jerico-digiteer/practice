class RemoveQuantityFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :quantity, :integer
  end
end
