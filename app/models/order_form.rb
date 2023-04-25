class OrderForm
  include ActiveModel::Model
  
  attr_accessor :user_id, :item_id, :postal_code, :shipping_from_id, :city, :address1, :address2, :phone_number, :token

  with_options presence: true do

    validates :user_id
    validates :item_id

    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :shipping_from_id, numericality: { other_than: 1 }
    validates :city
    validates :address1
    validates :phone_number, format: {with: /\A\d{10,11}\z/ }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingDestination.create(order_id: order.id, postal_code: postal_code, shipping_from_id: shipping_from_id, city: city, address1: address1, address2: address2, phone_number: phone_number)
  end
end
