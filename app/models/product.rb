# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  price       :decimal(, )
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :cover
  has_many_attached :images
  has_many :has_categories
  has_many :categories, through: :has_categories
  attr_accessor :category_elements

  validates :name, presence: true


  def save_categories
    #ids separados por coma
    #Convertir eso en arreglo 1,2,3 -> [1,2,3]
    #Iterar el arreglo
    category_elements.each do |category_id|
      HasCategory.find_or_create_by(product: self, category_id: category_id)
    end
    #Crear hasCategory
  end
  
end
