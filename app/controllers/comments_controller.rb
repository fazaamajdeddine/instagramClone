class CommentsController < ApplicationController
    before_action :authenticate_user!

    def index
      @comments = @post.comments.includes(:user)
    end
  
    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        @post = @comment.post
        respond_to :js
      else
        flash[:alert] = "Something went wrong ..."
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      @post = @comment.post
      if @comment.destroy
        respond_to :js
      else
        flash[:alert] = "Something went wrong ..."
      end
    end
  
    private

    def comment_params
      params.require(:comment).permit(:body, :user_id, :post_id)
    end

end
