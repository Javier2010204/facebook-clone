# == Schema Information
#
# Table name: in_shopping_carts
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :integer          not null
#  shopping_cart_id :integer          not null
#
# Indexes
#
#  index_in_shopping_carts_on_product_id        (product_id)
#  index_in_shopping_carts_on_shopping_cart_id  (shopping_cart_id)
#
# Foreign Keys
#
#  product_id        (product_id => products.id)
#  shopping_cart_id  (shopping_cart_id => shopping_carts.id)
#
require 'test_helper'

class InShoppingCartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
