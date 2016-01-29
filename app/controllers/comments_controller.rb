class CommentsController < ApplicationController
  respond_to :json

  def create
    respond_to do |format|
      format.json  { render :json => params[:_json] } # don't do msg.to_json
    end
  end

  def index
    @comment = Post.find(params[:post_id]).comments

    respond_with @comment
  end

  def like
    comment = Comment.find(params[:_json])
    current_user.comment_likes << comment

    respond_to do |format|
      format.json  { render :json => params[:_json] } # don't do msg.to_json
    end
  end
end
