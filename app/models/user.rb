class User < ApplicationRecord
  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :cart_items, dependent: :destroy
  has_many :orders

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add additional validations or associations if needed
  def full_name
    "#{first_name} #{last_name}"
  end
  
end
