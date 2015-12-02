class UsersController < ApplicationController

  def index
    @users = User.where("first_name like ? OR last_name like ?", "%" + params[:q].to_s + "%","%" + params[:q].to_s + "%").distinct
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.wall.posts.all
    @debugText = params
    @post = Post.new
  end

end
