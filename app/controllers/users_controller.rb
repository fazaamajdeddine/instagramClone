class UsersController < ApplicationController
before_action :authenticate_user!
before_action :set_users, only: [:profile]
#devise_for :users

  def index
    @posts = Post.all
    @comment = Comment.new
    @users = User.search(params[:term])
    respond_to :js
  end


  



  def profile
      #user profile
      @posts = @user.posts.order("created_at DESC")
      

      
  end


  

  private 

  def set_users
    @user = User.find_by(username: params[:username])
  end

  
  def user_params
    params.require(:user).permit(:username, :password, :avatar)
  end

  



end
