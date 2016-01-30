class CommentsController < ApplicationController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def create
    @comment = Comment.new
    @comment.user_id = params[:user_id]
    @comment.post_id = params[:post_id]
    @comment.text = params[:text]
    if !@comment.save
      @comment = "failed"
    end

    # respond_with @comment
    respond_to do |format|
      format.json  { render :json => @comment } # don't do msg.to_json
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
