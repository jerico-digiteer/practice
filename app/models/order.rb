class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_price, numericality: { greater_than: 0 }

  enum shipment_status: { shipment_pending: 'shipment_pending', shipped: 'shipped', delivered: 'delivered' }
  enum payment_status: { payment_pending: 'payment_pending', paid: 'paid', refunded: 'refunded' }

  def calculate_total_price
    self.total_price = order_items.sum(&:total_price)
  end
end
