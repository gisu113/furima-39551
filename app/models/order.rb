class Order < ApplicationRecord
  attr_accessor :token
  belongs_to :user
  has_many :addresses
end