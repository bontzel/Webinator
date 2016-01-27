class CommentsController < ApplicationController
  def create
    Comment.create(:text => params[:comment][:text], :user_id => current_user.id, :post_id => params[:post_id])
    redirect_to :back
  end

  def like
    user = User.find(params[:user_id])
    user.post_likes << Post.find(params[:post_id])

    redirect_to :back
  end
end
