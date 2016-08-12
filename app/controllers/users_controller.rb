class UsersController < ApplicationController

  def index
    @profiles = Profile.where("first_name like ? OR last_name like ?", "%" + params[:q].to_s + "%","%" + params[:q].to_s + "%").distinct
    @users = []
    @profiles.each do |p|
      @users << p.user
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.wall.posts.all
    @post = Post.new
  end

end
