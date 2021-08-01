class FriendshipsController < ApplicationController
    before_action :find_friend, except: [:index, :update]
    before_action :find_friendship, only: [:update]


    def index
        @pending_friendships = current_user.followers.pending.decorate
        @accepted_friendships = current_user.followers.active.decorate
        @friends = current_user.friendships.active.decorate
        @pending_requests = current_user.friendships.pending.decorate
    end

    def update

        if params[:status] == "1"
            @friendship.accepted!
        else
            @friendship.rejected!
        end

        respond_to do |format|
            format.html { redirect_to friendships_path}
        end
    end
    

    def create
        friendship = Friendship.new(user: current_user, friend: @friend)

        respond_to do |format|
            if friendship.save
                format.html{redirect_to @friend}
            else
                format.html{redirect_to @friend, notice: "Error en la solicitud de amistad"}
            end
        end
    end
    
    
    private
        def friendship_params
            require(:friendship).permit(:status)
        end
        

        def find_friend
            @friend = User.find(params[:friend_id])
        end

        def find_friendship
            @friendship = Friendship.find(params[:id])
        end     
end