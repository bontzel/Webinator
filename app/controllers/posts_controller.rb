class PostsController < ApplicationController
  def create
      @wall = Wall.find(params[:wall_id])
      Post.create(:text => params[:post][:text], :user_id => current_user.id, :wall_id => @wall.id)

      redirect_to :back
  end

  def like
    user = User.find(params[:user_id])
    user.post_likes << Post.find(params[:post_id])

    redirect_to :back
  end
end
