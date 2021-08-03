class UsersController < ApplicationController
  before_action :set_user
  
  def show
    @are_friends = current_user.is_my_friend?(@user)
    @my_account = current_user.is_my_profile?(@user)
    @are_pending_request = current_user.is_pending_request(@user)
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
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:avatar, :username, :bio, :cover)
    end
    
    
end
