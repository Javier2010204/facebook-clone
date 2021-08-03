class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body 

  scope :last_posts, -> {order("created_at desc")}


  def self.all_post_for_user(user)
    Post.where(user_id: user.id).or(Post.where(user_id: user.friends_ids)).or(Post.where(user_id: user.user_ids))
  end
  
end
