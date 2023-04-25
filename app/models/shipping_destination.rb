class ShippingDestination < ApplicationRecord
  validates :postal_code,  presence: true
  validates :shipping_from_id,    presence: true
  validates :city, presence: true
  validates :address1,      presence: true
  validates :phone_number, presence: true

  belongs_to :order
end
