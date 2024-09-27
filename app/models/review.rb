class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :rating, presence: true, inclusion: { in: 0..5 }
  validates :comment, length: { maximum: 500 }
  validate :user_can_only_review_purchased_products

  private

  def user_can_only_review_purchased_products
    product_variant_ids = product.product_variants.pluck(:id)
# looks for user's exisiting orders if they have already ordered the product
    unless user.orders.joins(:order_items).where(order_items: { product_variant_id: product_variant_ids }).exists?
      errors.add(:base, "You can only review products you've purchased.")
    end
  end
end
