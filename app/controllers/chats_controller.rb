class ChatsController < ApplicationController

    def index
        @chats = Chat.all
    end

    def show
        @chat = Chat.find(params[:id])
        @message = current_user.messages.new
    end
    
    
end
