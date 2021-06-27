class MessagesController < ApplicationController 
    skip_before_action :verify_authenticity_token, :only => [:create]
    before_action do 
        @conversation = Conversation.find(params[:conversation_id])
    end

    def index 
        @messages = @conversation.messages 
        @message = @conversation.messages.new 
    end

    def new 
        @message = @conversation.messages.new
    end

    def create
        @message = @conversation.messages.new(message_params)
        if @message.save
          redirect_to authenticated_root_path
        end
    end

        private 

        def message_params 
            params.require(:message).permit(:body, :user_id)
        end

end