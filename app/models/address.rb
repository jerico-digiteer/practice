class Address < ApplicationRecord
  belongs_to :user

  validates :city, :country, :zip, presence: true
end
