# == Schema Information
#
# Table name: shopping_carts
#
#  id         :integer          not null, primary key
#  ip         :string
#  status     :integer          default("default")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_shopping_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class ShoppingCart < ApplicationRecord
  belongs_to :user 
  has_many :products, through: :in_shopping_carts
  has_many :in_shopping_carts

  enum status: {payed:1, default: 0}
end
