class WallsController < ApplicationController
  def show
    @wall = Wall.find(params[:id])
    @posts = @wall.posts
    @post = Post.new
  end
end
