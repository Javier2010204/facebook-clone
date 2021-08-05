class HomeController < ApplicationController
  def index
    @posts = Post.all_post_for_user(current_user).last_posts.paginate(page:params[:page], per_page:10)
    @post = current_user.posts.new
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
