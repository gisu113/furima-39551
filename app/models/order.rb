class Order < ApplicationRecord
  attr_accessor :token

  belongs_to :user
  has_one :address
  belongs_to :item
end
