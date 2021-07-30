class HomeController < ApplicationController
  def index
    @posts = Post.all
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
