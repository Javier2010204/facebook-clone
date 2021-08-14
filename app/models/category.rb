# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  color      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Category < ApplicationRecord
    belongs_to :user
    has_many :has_categories
    has_many :products, through: :has_categories
end
