class PostsController < ApplicationController
  def create
      @wall = Wall.find(params[:wall_id])
      Post.create(:text => params[:post][:text], :user_id => current_user.id, :wall_id => @wall.id)

      redirect_to :back
  end

  def like
    post = Post.find(params[:_json])
    current_user.post_likes << post

    respond_to do |format|
      format.json  { render :json => params[:_json] } # don't do msg.to_json
    end
  end
end
