class Order < ApplicationRecord
  belongs_to :end_user
	has_many :ordered_items
	enum payment_method: {銀行振込:0, クレジットカード:1}
end
