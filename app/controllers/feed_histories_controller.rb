class FeedHistoriesController < ApplicationController
  def show
    @posts = current_user.feed_history.posts
  end
end
