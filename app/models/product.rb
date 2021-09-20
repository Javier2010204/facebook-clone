# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  price       :decimal(, )
#  slug        :string
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer          not null
#
# Indexes
#
#  index_products_on_slug     (slug) UNIQUE
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Product < ApplicationRecord

  extend FriendlyId

  belongs_to :user
  has_one_attached :cover
  has_many_attached :images
  has_many :has_categories
  has_many :categories, through: :has_categories
  attr_accessor :category_elements

  validates :name, presence: true, uniqueness: true

  friendly_id :name, use: :slugged


  def save_categories
    #ids separados por coma
    #Convertir eso en arreglo 1,2,3 -> [1,2,3]
    #Iterar el arreglo
    return has_categories.destroy_all if category_elements.nil? || category_elements.empty?
    has_categories.where.not(category_id: category_elements).destroy_all
    category_elements.each do |category_id|
      HasCategory.find_or_create_by(product: self, category_id: category_id)
    end
    #Crear hasCategory
  end
  
end
