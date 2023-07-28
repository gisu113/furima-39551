class Order < ApplicationRecord
  belongs_to :item
  has_one :order_address
end
