class PostsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    Post.create(:text => params[:post][:text], :user_id => current_user.id, :wall_id => @user.wall.id)

    redirect_to :back
  end
end
