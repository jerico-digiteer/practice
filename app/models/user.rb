class User < ApplicationRecord
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :cart_items, dependent: :destroy

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add additional validations or associations if needed

end
