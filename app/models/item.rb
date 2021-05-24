class Item < ApplicationRecord
  attachment :image
  has_many :cart_items
  has_many :ordered_items
  belongs_to :genre

  enum is_active: {販売中:true,販売停止:false}
end
