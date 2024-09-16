class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :shipment_status, presence: true
  validates :payment_status, presence: true

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = order_items.sum(&:total_price)
  end
end
