class MessagesController < ApplicationController
    before_action :set_chat

    def new
        @message = current_user.message
    end

    def create
        @message = current_user.messages.new(message_params)
        @message.chat = @chat

        respond_to do |format|
            if @message.save
                format.html{redirect_to @chat, notice: 'mensaje enviado con éxito'}
            else
                format.html{redirect_to @chat, alert: 'no se pudo enviar el mensaje intenta mas tarde'}
            end
        end
    end
    


    private

        def set_chat
            @chat = Chat.find(params[:chat_id])
        end

        def message_params
            params.require(:message).permit(:content)
        end
        
        
    
end
