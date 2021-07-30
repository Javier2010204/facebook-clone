class FriendshipsController < ApplicationController
    before_action :find_friend, except: [:index]


    def index
        @pending_friendships = Friendship.pending_for_user(current_user)
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

        def find_friend
            @friend = User.find(params[:friend_id])
        end
        
end