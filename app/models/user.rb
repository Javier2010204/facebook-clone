class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true

  has_many :posts
  has_many :products
  has_many :friendships
  has_many :followers, class_name: "Friendship", foreign_key: "friend_id"
  
  has_many :friends_added, through: :friendships, source: :friend
  has_many :friends_who_added, through: :friendships, source: :user

  has_one_attached :avatar
  has_one_attached :cover

  def friends_ids
    #donde yo soy el user
    Friendship.active.where(user:self).pluck(:friend_id)
  end

  def user_ids
    #donde yo soy el friend
    # pluck -> devuelve un arreglo con los ids de las personas que me agregaron y yo acepte
    Friendship.active.where(friend:self).pluck(:user_id)
  end

  def is_my_friend?(friend)
    Friendship.friends?(self, friend)
  end

  def is_pending_request(friend)
    Friendship.pending_request?(self, friend)
  end
  

  def is_my_profile?(friend)
    return true if self == friend
  end
  
  
  
end
