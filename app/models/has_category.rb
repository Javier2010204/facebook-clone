# == Schema Information
#
# Table name: has_categories
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  product_id  :integer          not null
#
# Indexes
#
#  index_has_categories_on_category_id  (category_id)
#  index_has_categories_on_product_id   (product_id)
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#  product_id   (product_id => products.id)
#
class HasCategory < ApplicationRecord
  belongs_to :product
  belongs_to :category
  
end
