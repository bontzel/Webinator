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

    post = Post.find(@comment.post_id)

    if @comment.user.id != post.user.id
      Notification.create(:user_id => post.user.id, :actor_id => current_user.id, :notifiable_id => @comment.id, :notifiable_type => 'Comment', :message_type => 0, :seen => false)
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
    comment = Comment.find(params[:id])
    current_user.comment_likes << comment

    if comment.user.id != current_user.id
      Notification.create(:user_id => comment.user.id, :actor_id => current_user.id, :notifiable_id => comment.id, :notifiable_type => 'Comment', :message_type => 1, :seen => false)
    end

    respond_to do |format|
      format.json  { render :json => params[:_json] } # don't do msg.to_json
    end
  end

  def check_for_like
    @check = current_user.comment_likes.where( :id => params[:id]).present?

    respond_to do |format|
      format.json  { render :json => @check } # don't do msg.to_json
    end
  end
end
