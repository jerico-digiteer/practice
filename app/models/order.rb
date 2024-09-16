class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_price, numericality: { greater_than: 0 }
  validates :shipment_status, inclusion: { in: %w[pending shipped delivered] }
  validates :payment_status, inclusion: { in: %w[paid unpaid] }

  def calculate_total_price
    self.total_price = order_items.sum(&:total_price)
  end
end
