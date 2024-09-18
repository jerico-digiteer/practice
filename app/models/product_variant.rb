class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :cart_items

  def name_with_price_stock
    "#{name} - $#{price} (Stock: #{stock_quantity})"
  end

  def name_and_price
    "#{name} - $#{price} (Stock: #{stock_quantity})"
  end

  def in_stock?
    stock_quantity > 0
  end
end
