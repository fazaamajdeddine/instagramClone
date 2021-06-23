class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [ :vote ]
  before_action :set_post, only: [:show, :vote]  
  respond_to :js, :json, :html
  
  
  def index
     
    if logger
    @comment = Comment.new
    #@comment = @post.comments.find(params[:id])
    @users = User.where(id: params[:user_id])
    @posts = Post.all.order("created_at DESC")
    else
    @posts = Post.posts_of_followings(current_user.following)
    
    end
  end

  def show
    
  end
  
  def new
    @post = current_user.posts.new 
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id if user_signed_in?
 
    if @post.save 
     redirect_to authenticated_root_path, notice: "it wa posted!"
    else
     redirect_to new_post_path     
    end
 end

  def edit 
    if @post.user != current_user
      flash.now[:error] = 'unauthorized access!'
      redirect_to posts_path
   end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "post was updated!"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.js { render 'update', layout: false }
    end 
  end

  def vote 
    if !current_user.liked? @post 
      @post.liked_by current_user 
    elsif current_user.liked? @post 
      @post.unliked_by current_user 
    end
  end

  private

  def set_post
    @post = Post.find(params[:id]) if params[:id].present?
  end 

  def post_params
    params.require(:post).permit(:image, :caption, :user_id)
  end

  def find_post
    @post = Post.find(params[:id]) 
  end
end
