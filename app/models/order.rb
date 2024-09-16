class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :total_price, numericality: { greater_than: 0 }
  enum shipment_status: { pending: 'Pending', shipped: 'Shipped', delivered: 'Delivered' }
  enum payment_status: { pending: 'Pending', paid: 'Paid', refunded: 'Refunded' }


  def calculate_total_price
    self.total_price = order_items.sum(&:total_price)
  end
end
