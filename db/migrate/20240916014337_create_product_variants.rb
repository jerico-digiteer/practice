class CreateProductVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :product_variants do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.integer :stock_quantity

      t.timestamps
    end
  end
end
