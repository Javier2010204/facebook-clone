class ChatsController < ApplicationController
    before_action :authenticate_user!

    def index
        @chats = Chat.all
    end

    def show
        @chat = Chat.find(params[:id])
        @message = current_user.messages.new
    end
    
    
end
