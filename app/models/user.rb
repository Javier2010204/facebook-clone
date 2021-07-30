class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_many :posts
  has_many :products

  has_one_attached :avatar
  has_one_attached :cover


  def is_my_friend?(friend)
    Friendship.friends?(self, friend)
  end

  def is_my_profile?(friend)
    return true if self == friend
  end
  
  
  
end
