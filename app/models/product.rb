class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :cover
  has_many_attached :images
end
