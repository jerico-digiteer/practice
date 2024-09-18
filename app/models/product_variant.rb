class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :cart_items

    def name_and_price
      "#{name} - $#{price} (Stock: #{stock_quantity})"
    end
end
