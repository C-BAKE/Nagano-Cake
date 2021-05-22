class Order < ApplicationRecord
  has_many :orders_item
  belongs_to :end_user
end
