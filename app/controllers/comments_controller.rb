class CommentsController < ApplicationController
    before_action :authenticate_user!
    
    

    def create 
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id if user_signed_in?
        @comment.save 
          
         
    end

    def destroy 
        @comment.destroy
        
    end

    


    private

    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end

end
