class HomeController < ApplicationController
  def index
    @posts = Post.all_post_for_user(current_user)
    @post = current_user.posts.new
    @amigos = current_user.friends_ids
    @amigos_agregaron = current_user.user_ids
  end

  def unregistered
    
  end

  def set_layout
    if action_name == "unregistered"
      return "landing"
    else
      super
    end
  end
  

  
end
