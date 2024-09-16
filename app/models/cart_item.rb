class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product_variant

  validates :quantity, presence: true
  validates :price, presence: true
  validates :total_price, presence: true

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = price * quantity
  end
end
