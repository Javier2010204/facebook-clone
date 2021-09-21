# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_rich_text :body 

  scope :last_posts, -> {order("created_at desc")}


  def liked?(user)
    !!self.likes.find{|like| like.user_id == user.id}
  end
  

  def self.all_post_for_user(user)
    Post.where(user_id: user.id).or(Post.where(user_id: user.friends_ids)).or(Post.where(user_id: user.user_ids))
  end
  
end
