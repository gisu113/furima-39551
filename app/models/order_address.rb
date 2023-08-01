class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :city, :house_number, :building_name, :phone_number, :prefecture_id, :user_id, :item_id, :token

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/,message: "is invalid. Include hyphen(-)"}
    # 必要に応じてbuilding_nameとphone_numberのバリデーションも追加する
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  end

  
  def save
  order = Order.create(item_id: item_id, user_id: user_id)
  Address.create(postal_code: postal_code, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id, prefecture_id: prefecture_id)
  end
end
