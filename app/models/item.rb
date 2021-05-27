class Item < ApplicationRecord


  has_many :cart_items
  has_many :ordered_items
  belongs_to :genre

  attachment :image

  enum is_active: {販売中:true,販売停止中:false}
end
