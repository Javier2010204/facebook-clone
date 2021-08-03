class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  validates :user_id, uniqueness:{scope: :friend_id, message:"Amistad duplicada" }


  def self.friends?(user, friend)
    return true if friend == user
    return Friendship.where(user: user, friend: friend).or(Friendship.where(user: friend, friend: user)).any?
  end
  
  def self.friend_status(user,friend)
    return Friendship.where(user: user, friend: friend).or(Friendship.where(user: friend, friend: user))
  end
  
  
  
  

  include AASM

  aasm column: "status" do
    state :pending, initial: true
    state :active
    state :denied

    event :accepted do
      transitions from: [:pending], to:[:active]
    end

    event :rejected do
      transitions from: [:pending, :active], to:[:denied]
    end
  end
end
