class FollowsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_user
    
    def create 
        #@user = User.find_by(params[:id])
        current_user.follow(@user)
        redirect_to authenticated_root_path
    end

    def destroy
        #@user = User.find_by(params[:id])
        current_user.unfollow(@user)
        redirect_to authenticated_root_path
    end

    private

    def find_user
        @user = User.find(params[:user_id])
    end
end


