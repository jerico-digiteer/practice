class Product < ApplicationRecord
    has_many :product_variants, dependent: :destroy
    accepts_nested_attributes_for :product_variants, allow_destroy: true
    validates :name, presence: true, length: {minimum: 5, maximum: 50}
    validates :description, presence: true, length: {minimum: 10, maximum: 100}
  end
  