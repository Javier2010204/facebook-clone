class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  
  def show
    @posts = current_user.posts
  end
  
  def edit
  end

  def update
    @user.update(user_params)

    #redirect_back(fallback_location: root_path)

    respond_to do |format|
      format.html { render :show}
    end
  end

  private

    def set_user
      @user = User.find(params[:id]).decorate
    end

    def user_params
      params.require(:user).permit(:avatar, :username, :bio, :cover)
    end
    
    
end
